require 'open-uri'
require 'nokogiri'

url_consumo = "http://www.ons.org.br/home/grafico.asp"
doc_consumo = Nokogiri::HTML(open(url_consumo))
consumo = doc_consumo.css("b").children.text.split(" ")[0]
puts consumo

url_reserva = "http://www.ons.org.br/home/reservatorio.asp"
doc_reserva = Nokogiri::HTML(open(url_reserva)).xpath('//table/tr')
reservas = []
reservas << [doc_reserva.xpath('//tr[2]/td[1]').text, doc_reserva  .xpath('//tr[2]/td[2]').text]
reservas << [doc_reserva.xpath('//tr[3]/td[1]').text, doc_reserva  .xpath('//tr[3]/td[2]').text]
reservas << [doc_reserva.xpath('//tr[4]/td[1]').text, doc_reserva  .xpath('//tr[4]/td[2]').text]
reservas << [doc_reserva.xpath('//tr[5]/td[1]').text, doc_reserva  .xpath('//tr[5]/td[2]').text]
p reservas
