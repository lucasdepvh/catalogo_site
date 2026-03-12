puts "Iniciando seed..."

admin_email = ENV.fetch("SEED_ADMIN_EMAIL", "admin@prata925.com")
admin_password = ENV.fetch("SEED_ADMIN_PASSWORD", "123456")

admin = Admin.find_or_initialize_by(email: admin_email)
admin.password = admin_password if admin.new_record?
admin.password_confirmation = admin_password if admin.new_record?
admin.save!

catalogo = {
  "Aneis 925" => [
    { code: "ANL-001", title: "Anel Coracao Vazado", price: 59.90, description: "Anel em prata 925 com acabamento polido e design delicado para uso diario." },
    { code: "ANL-002", title: "Anel Solitario Zircônia", price: 79.90, description: "Modelo solitario em prata 925 com pedra de zirconia e aro anatomico." },
    { code: "ANL-003", title: "Anel Ajustavel Trancado", price: 69.90, description: "Peca ajustavel em prata 925 com trama trancada e visual moderno." }
  ],
  "Brincos 925" => [
    { code: "BRC-001", title: "Brinco Argola Lisa P", price: 52.90, description: "Argola em prata 925 leve e versatil, ideal para revenda de giro rapido." },
    { code: "BRC-002", title: "Brinco Gota Cravejada", price: 74.50, description: "Brinco em prata 925 com microcravacao e formato de gota." },
    { code: "BRC-003", title: "Brinco Ponto de Luz", price: 49.90, description: "Classico ponto de luz em prata 925, combinando com todos os estilos." }
  ],
  "Pulseiras 925" => [
    { code: "PLS-001", title: "Pulseira Elo Portugues", price: 128.00, description: "Pulseira em prata 925 com elo portugues e fecho reforcado." },
    { code: "PLS-002", title: "Pulseira Riviera Zircônia", price: 189.90, description: "Riviera em prata 925 com pedras de zirconia e brilho intenso." },
    { code: "PLS-003", title: "Pulseira Malha Cartier", price: 139.90, description: "Modelo malha cartier em prata 925 para compor mix de pulseiras." }
  ],
  "Colares 925" => [
    { code: "CLR-001", title: "Colar Ponto de Luz", price: 98.90, description: "Colar em prata 925 com pingente de ponto de luz e corrente veneziana." },
    { code: "CLR-002", title: "Colar Medalha Lisa", price: 112.50, description: "Corrente em prata 925 com medalha lisa para gravacao personalizada." },
    { code: "CLR-003", title: "Colar Coração Vazado", price: 104.90, description: "Colar com pingente de coracao vazado em prata 925, acabamento espelhado." }
  ],
  "Pingentes 925" => [
    { code: "PNG-001", title: "Pingente Cruz Minimalista", price: 45.00, description: "Pingente cruz em prata 925 de traco limpo e excelente saida comercial." },
    { code: "PNG-002", title: "Pingente Letra A", price: 39.90, description: "Pingente inicial em prata 925 para composicao de colares personalizados." },
    { code: "PNG-003", title: "Pingente Trevo da Sorte", price: 47.50, description: "Pingente em prata 925 com design de trevo e alto valor percebido." }
  ]
}

created_products = 0

catalogo.each do |category_name, products|
  category = Category.find_or_create_by!(description: category_name)

  products.each do |attrs|
    product = Product.find_or_initialize_by(identification_code: attrs[:code])
    product.category = category
    product.title = attrs[:title]
    product.description = attrs[:description]
    product.price = attrs[:price]
    created_products += 1 if product.new_record?
    product.save!
  end
end

puts "Seed finalizado com sucesso."
puts "Admin: #{admin.email}"
puts "Categorias: #{Category.count}"
puts "Produtos: #{Product.count} (novos nesta execucao: #{created_products})"
