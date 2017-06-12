require 'open-uri'
require 'nokogiri'

# Consumo to SNE
url_consumo = "http://www.ons.org.br/home/grafico.asp"
doc_consumo = Nokogiri::HTML(open(url_consumo))
consumo = [ doc_consumo.css("b").children.text.split(" ")[0],
            doc_consumo.css("#data").text.split(" ")[1]
          ]

# Nivel dos reservatorios
url_reserva = "http://www.ons.org.br/home/reservatorio.asp"
doc_reserva = Nokogiri::HTML(open(url_reserva)).xpath('//table/tr')
reservas = []
(2..5).each do |n|
  reservas << [ doc_reserva.xpath("//tr[#{n}]/td[1]").text,
                doc_reserva.xpath("//tr[#{n}]/td[2]").text
              ]
end

#Ultimo IPDO
url_ipdo = 'http://www.ons.org.br/publicacao/ipdo/'

data_year = Nokogiri::HTML(open(url_ipdo))
last_year = data_year.xpath('//a[last()-1]')[0].text.split("_")[1].to_i
link_last_year = data_year.xpath('//a[last()-1]')[0].attributes["href"].value

url_month = 'http://www.ons.org.br' + link_last_year
data_month = Nokogiri::HTML(open(url_month))
last_month = data_month.xpath('//a[last()]')[0].text.split("_")[1].to_i
link_last_month = data_month.xpath('//a[last()]')[0].attributes["href"].value

url_day = 'http://www.ons.org.br' + link_last_month
data_day = Nokogiri::HTML(open(url_day))
last_real_day = data_day.xpath('//a[last()]')[0].text.split("-")[1]
last_real_month = data_day.xpath('//a[last()]')[0].text.split("-")[2]
last_real_year = data_day.xpath('//a[last()]')[0].text.split("-")[3]
last_real_date = Date::strptime("#{last_real_day}-#{last_real_month}-#{last_real_year}", "%d-%m-%Y")
last_real_date_link = 'http://www.ons.org.br' + data_day.xpath('//a[last()]')[0].attributes["href"].value

# print
puts "Consumo:"
p consumo
puts "Nivel dos reservatorios"
p reservas
puts "Ultimo IPDO"
puts [last_real_date, last_real_date_link]
