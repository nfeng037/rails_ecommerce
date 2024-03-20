# Create AdminUser
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Web scraping script
require 'open-uri'

nailformula_url = 'https://nailformula.ca'

# cleto_color_gel_url = nailformula_url + '/collections/cleto-color-gel'
# cleto_color_gel_html = URI.open(cleto_color_gel_url).read
# cleto_color_gel_doc = Nokogiri::HTML(cleto_color_gel_html)

# cletos = cleto_color_gel_doc.css('div.product')

# # Loop over all the products divs located by the CSS selector
# cletos.each do |cleto_color|
#   # Extract the Cleto name, price, image and the URL of the product page.
#   cleto_link = cleto_color.css('a.product-block-title')
#   cleto_color_name = cleto_color.text.strip
#   cleto_color_href = cleto_link.attribute('href').content
#   cleto_color_price = cleto_color.css('span.price').text.strip
#   cleto_image_url = cleto_color.css('div.product-image__primary noscript img').first['src']
#   cleto_image_url = "https: #{cleto_image_url}"

#   # Visit each product page to extra the product description.
#   cleto_page_html = URI.open("#{nailformula_url}#{cleto_color_href}").read
#   cleto_page_doc = Nokogiri::HTML(cleto_page_html)
#   cleto_description = cleto_page_doc.css('div.descriptionunder p span').text

#   Product.create(
#     name: cleto_color_name,
#     description: cleto_description,
#     price: cleto_color_price.gsub(/[^0-9\.]/, '').to_f,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 2
#   )
# end

# url = nailformula_url + '/collections/ageha-clear-gel'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |ageha|
#   #Extract the ageha name, price and the URL of the product page.
#   ageha_name = ageha.css('a.product-block-title').text.strip
#   ageha_price = ageha.css('span.price').text.strip
#   ageha_href = ageha.css('a.product-block-title').attribute('href').content

#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{ageha_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   Product.create(
#     name: ageha_name,
#     price: ageha_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 1
#   )
# end

# url = nailformula_url + '/collections/ageha-solution'

# html_content = URI.open(url).read

# doc = Nokogiri::HTML(html_content)

# doc.css('div.product').each do |solution|
#   #Extract the solution name, price and the URL of the product page.
#   solution_name = solution.css('a.product-block-title').text.strip
#   solution_price = solution.css('span.price').text.strip
#   solution_href = solution.css('a.product-block-title').attribute('href').content

#   #Visit each product page to extra the description
#   page_html = URI.open("#{nailformula_url}#{solution_href}").read
#   page_doc = Nokogiri::HTML(page_html)
#   page_description = page_doc.css('div.descriptionunder p span').text

#   Product.create(
#     name: solution_name,
#     price: solution_price.gsub(/[^0-9\.]/, '').to_f,
#     description: page_description,
#     stock: rand(1..20),
#     active: [true, false].sample,
#     category_id: 5
#   )
# end

url = nailformula_url + '/collections/dinagel-other'

html_content = URI.open(url).read

doc = Nokogiri::HTML(html_content)

doc.css('div.product').each do |tool|
  #Extract the DINAGEL Other name, price and the URL of the product page.
  tool_name = tool.css('a.product-block-title').text.strip
  tool_price = tool.css('span.price').text.strip
  tool_href = tool.css('a.product-block-title').attribute('href').content

  #Visit each product page to extra the description
  page_html = URI.open("#{nailformula_url}#{tool_href}").read
  page_doc = Nokogiri::HTML(page_html)
  page_description = page_doc.css('div.descriptionunder p span').text

  Product.create(
    name: tool_name,
    price: tool_price.gsub(/[^0-9\.]/, '').to_f,
    description: page_description,
    stock: rand(1..20),
    active: [true, false].sample,
    category_id: 4
  )
end
