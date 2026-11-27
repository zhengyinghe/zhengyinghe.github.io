# Site-local styling and small HTML refinements; keep gem layouts intact.
require 'nokogiri'
Jekyll::Hooks.register [:pages, :documents], :post_render do |item|
  output = item.output
  next unless output.is_a?(String) && output.match?(%r{</head>}i)
  base = item.site.config.fetch('baseurl', '').to_s.sub(%r{/$}, '')
  unless output.include?('id="academic-site-style"')
    tag = %(<link id="academic-site-style" rel="stylesheet" href="#{base}/assets/custom/academic.css">)
    output = output.sub(%r{</head>}i) { |closing| "#{tag}\n#{closing}" }
  end
  home = item.data['layout'] == 'about' && item.url == '/'
  news_page = item.url == '/news/'
  if home || news_page
    doc = Nokogiri::HTML5.parse(output)
    if home
      profile = doc.at_css('.profile')
      icons = doc.at_css('.social .contact-icons') || doc.at_css('.contact-icons')
      if profile && icons && !icons.ancestors.include?(profile)
        social = icons.ancestors.find { |node| node['class'].to_s.split.include?('social') }
        if social
          social['class'] = [social['class'], 'academic-profile-social'].join(' ')
          profile.add_child(social.unlink)
        else
          wrapper = Nokogiri::XML::Node.new('div', doc)
          wrapper['class'] = 'academic-profile-social'
          wrapper.add_child(icons.unlink)
          profile.add_child(wrapper)
        end
      end
      doc.css('h2, h3').each do |heading|
        label = {'news' => 'News', 'selected publications' => 'Selected Publications'}[heading.text.strip.downcase]
        if label
          link = heading.at_css('a')
          (link || heading).content = label
        end
      end
    end
    doc.css('.news td, .news th, .news strong, .news time').each do |node|
      next unless node.element_children.empty?
      match = node.text.strip.match(/\A([A-Za-z]{3,9})\s+\d{1,2},\s*(\d{4})\z/)
      node.content = "#{match[1][0, 3]} #{match[2]}" if match
    end
    output = doc.to_html
  end
  item.output = output
end
