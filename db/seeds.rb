# Create AdminUser
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Web scraping script
require 'open-uri'

nailformula_url = 'https://nailformula.ca'

# Scrap Cleto Color Gel
# cleto_gel_url = nailformula_url + '/collections/cleto'
# cleto_gel_html = URI.open(cleto_gel_url).read
# cleto_gel_doc = Nokogiri::HTML(cleto_gel_html)

# cletos = cleto_gel_doc.css('div.product')

# # Loop over all the products divs located by the CSS selector
# cletos.each do |cleto|
#   # Extract the Cleto name, price, image and the URL of the product page.
#   cleto_name = cleto.css('a.product-block-title').text.strip
#   cleto_href = cleto.css('a.product-block-title').attribute('href').content
#   cleto_price = cleto.css('span.price').text.strip
#   cleto_image_url = cleto.css('div.product-image__primary noscript img').first['src'].split('?').first
#   cleto_image_url = "https:#{cleto_image_url}"

  # # Visit each product page to extra the product description.
  # cleto_page_html = URI.open("#{nailformula_url}#{cleto_href}").read
  # cleto_page_doc = Nokogiri::HTML(cleto_page_html)
  # cleto_description = cleto_page_doc.css('div.descriptionunder p span').text

  # product = Product.create(
  #   name: cleto_name,
  #   description: cleto_description,
  #   price: cleto_price.gsub(/[^0-9\.]/, '').to_f,
  #   stock: rand(1..20),
  #   active: [true, false].sample,
  #   category_id: 2
  # )

  # # Download image and attach to the product
  # begin
  #   download_image = URI.open(cleto_image_url)
  #   product.image.attach(io: download_image, filename: File.basename(URI.parse(cleto_image_url).path))
  # rescue OpenURI::HTTPError => e
  #   puts "Failed to download image for product #{product.name}: #{e.message}"
  # end
# end

# Scrap Clear Gel Product
# url = nailformula_url + '/collections/dinagel-clear-gel'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |dinagel_clear|
#   #Extract the dinagel_clear name, price，image and the URL of the product page.
#   dinagel_clear_name = dinagel_clear.css('a.product-block-title').text.strip
#   dinagel_clear_price = dinagel_clear.css('span.price').text.strip
#   dinagel_clear_href = dinagel_clear.css('a.product-block-title').attribute('href').content
#   dinagel_clear_image_url = dinagel_clear.css('div.product-image__primary noscript img').first['src'].split('?').first
#   dinagel_clear_image_url ="https:#{dinagel_clear_image_url}"

#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{dinagel_clear_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   product = Product.create(
#     name: dinagel_clear_name,
#     price: dinagel_clear_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 1
#   )

#   # Download image and attach to product
#   begin
#     download_image = URI.open(dinagel_clear_image_url)
#     product.image.attach(io: download_image, filename: File.basename(URI.parse(dinagel_clear_image_url).path))
#   rescue OpenURI::HTTPError => e
#     puts "Failed to download image for product #{dinagel_clear.name}: #{e.message}"
#   end
# end

# url = nailformula_url + '/collections/ageha-solution'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |solution|
#   #Extract the solution name, price and the URL of the product page.
#   solution_name = solution.css('a.product-block-title').text.strip
#   solution_price = solution.css('span.price').text.strip
#   solution_href = solution.css('a.product-block-title').attribute('href').content
#   solution_image_url = solution.css('div.product-image__primary noscript img').first['src'].split('?').first
#   solution_image_url ="https:#{solution_image_url}"
#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{solution_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   product = Product.create(
#     name: solution_name,
#     price: solution_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 5
#   )

#   # Download image and attach to product
#   begin
#     download_image = URI.open(solution_image_url)
#     product.image.attach(io: download_image, filename: File.basename(URI.parse(solution_image_url).path))
#   rescue OpenURI::HTTPError => e
#     puts "Failed to download image for product #{solution_image_url.name}: #{e.message}"
#   end
# end

# url = nailformula_url + '/collections/dinagel-other'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |tool|
#   #Extract the DINAGEL Other name, price and the URL of the product page.
#   tool_name = tool.css('a.product-block-title').text.strip
#   tool_price = tool.css('span.price').text.strip
#   tool_href = tool.css('a.product-block-title').attribute('href').content
#   tool_image_url = tool.css('div.product-image__primary noscript img').first['src'].split('?').first
#   tool_image_url ="https:#{tool_image_url}"

#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{tool_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   product = Product.create(
#     name: tool_name,
#     price: tool_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 4
#   )

#   # Download image and attach to product
#   begin
#     download_image = URI.open(tool_image_url)
#     product.image.attach(io: download_image, filename: File.basename(URI.parse(tool_image_url).path))
#   rescue OpenURI::HTTPError => e
#     puts "Failed to download image for product #{tool_image_url.name}: #{e.message}"
#   end
# end

# url = nailformula_url + '/collections/ageha-art'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |art|
#   #Extract the DINAGEL Other name, price and the URL of the product page.
#   art_name = art.css('a.product-block-title').text.strip
#   art_price = art.css('span.price').text.strip
#   art_href = art.css('a.product-block-title').attribute('href').content
#   art_image_url = art.css('div.product-image__primary noscript img').first['src'].split('?').first
#   art_image_url ="https:#{art_image_url}"

#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{art_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   product = Product.create(
#     name: art_name,
#     price: art_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 3
#   )

#   # Download image and attach to product
#   begin
#     download_image = URI.open(art_image_url)
#     product.image.attach(io: download_image, filename: File.basename(URI.parse(art_image_url).path))
#   rescue OpenURI::HTTPError => e
#     puts "Failed to download image for product #{art_image_url.name}: #{e.message}"
#   end
# end


