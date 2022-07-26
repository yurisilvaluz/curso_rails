namespace :dev do
  desc "Configura o Ambiente de Desenvolvimento"
  task setup: :environment do
  if Rails.env.development?
    show_spinner("Apagando BD...") { %x(rails db:drop) }
    show_spinner("Criando banco de dados..") { %x(rails db:create) }
    show_spinner("Migrando Dados..") { %x(rails db:migrate) }
        %x(rails dev:add_mining_types)
        %x(rails dev:add_coins)

    
  else 
    puts "Voce nao está em ambiente de desenvolvimento!"
    end
  end
  
  desc "Cadastra as Moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando Moedas..") do
  coins = [
      { 
          description: "Bitcoin",
          acronym: "BTC",
          url_image: "https://e7.pngegg.com/pngimages/261/204/png-clipart-bitcoin-bitcoin-thumbnail.png",
          mining_type: MiningType.find_by(acronym: 'PoW')
      },
      {  
          description: "Ethereum",
          acronym: "ETH",
          url_image: "https://w7.pngwing.com/pngs/368/176/png-transparent-ethereum-cryptocurrency-blockchain-bitcoin-logo-bitcoin-angle-triangle-logo-thumbnail.png",
          mining_type: MiningType.all.sample
      },        
      { 
          description: "Dash",
          acronym: "DASH",
          url_image: "https://images.getpng.net/uploads/preview/cryptocurrency-vector-coins-icons-isolated-white-background-98-1151646499716eb1owavio8.webp",
          mining_type: MiningType.all.sample
      },
      {  
          description: "Iota",
          acronym: "IOT",
          url_image: "https://image.shutterstock.com/image-vector/golden-iota-coin-crypto-currency-260nw-779202067.jpg",
          mining_type: MiningType.all.sample
      },        
      { 
          description: "ZCash",
          acronym: "ZEC",
          url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/1437.png",
          mining_type: MiningType.all.sample
      }
  ]
    coins.each do |coin|
      Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra os tipos de Mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração..") do
      mining_types = [
        {description: "Proof of Work", acronym: "PoW"},
        {description: "Proof of Stake", acronym: "PoS"},
        {description: "Proof of Capacity", acronym: "PoC"}
    ]  
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end  
  end

  private
  def show_spinner(msg_start, msg_end = "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")

    end
end