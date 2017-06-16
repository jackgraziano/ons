require 'open-uri'
require 'nokogiri'
require 'net/http'

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

# load
url = "http://www.maximacomercializadora.com/api/v1/loads?date=#{consumo[1]}&load=#{consumo[0]}"
uri = URI(url)
res = Net::HTTP.post_form(uri, q:0)
puts res

url = "http://www.maximacomercializadora.com/api/v1/reservoirs?"\
      "date=#{Date.today-1}&"\
      "SE=#{reservas[0][1]}&"\
      "S=#{reservas[1][1]}&"\
      "NE=#{reservas[2][1]}&"\
      "NO=#{reservas[3][1]}"
puts url
uri = URI(url)
res = Net::HTTP.post_form(uri, q:0)
puts res
