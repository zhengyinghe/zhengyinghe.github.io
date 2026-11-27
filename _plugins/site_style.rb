# Load site-local styling after the theme, without replacing gem layouts.
Jekyll::Hooks.register [:pages, :documents], :post_render do |item|
  output = item.output
  next unless output.is_a?(String) && output.match?(%r{</head>}i)
  next if output.include?('id="academic-site-style"')
  base = item.site.config.fetch('baseurl', '').to_s.sub(%r{/$}, '')
  tag = %(<link id="academic-site-style" rel="stylesheet" href="#{base}/assets/custom/academic.css">)
  item.output = output.sub(%r{</head>}i) { |closing| "#{tag}\n#{closing}" }
end
