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

# print
p consumo
p reservas
