require 'faker'
require "csv"
require 'json'
require "open-uri"
require 'tty-progressbar'

# CLOUDINARY STORAGE SET TO FALSE WHEN TESTING THE SEED

cloudinary_storage = true

# CLEANING DB

puts "Cleaning Database..."
License.destroy_all
Scope.destroy_all
Plan.destroy_all
Review.destroy_all
Tool.all.each { |tool| tool.logo.purge_later }
Tool.destroy_all
User.destroy_all
Team.destroy_all
Organization.destroy_all
puts "Database cleaned"

# ORGANIZATION

puts "Creating Organization..."

organization = Organization.create!(name: "Mistral AI")

puts "#{Organization.count} organizations created!"

# TEAMS AND PEOPLE

puts "Creating Teams & People"

people_data = {
  "Marketing" => {
    employees: [["Peggy", "Olson"], ["Roger", "Sterling"], ["Joan", "Holloway"], ["Pete", "Campbell"], ["Bert", "Cooper"], ["Ken", "Cosgrove"]],
    manager: ["Don", "Draper"]
  },
  "Sales" => {
    employees: [["Jordan", "Belfort"], ["Frank", "Abagnale"], ["Charles", "Ponzi"], ["Billy", "McFarland"], ["Elizabeth", "Holmes"], ["Anna", "Delvey"], ["Jeffrey", "Skilling"]],
    manager: ["Bernard", "Madoff"]
  },
  "Operations" => {
    employees: [["Al", "Capone"], ["Jesse", "James"], ["Bonnie", "Parker"], ["Clyde", "Barrow"], ["Vito", "Corleone"], ["Tony", "Montana"]],
    manager: ["Pablo", "Escobar"]
  },
  "Human Ressources" => {
    employees: [["Joseph", "Staline"], ["Kim", "Jong-un"], ["Jeff", "Bezos"], ["Mark", "Zuckerberg"], ["Steve", "Jobs"], ["Gordon", "Ramsay"]],
    manager: ["Elon", "Musk"]
  },
  "Tech" => {
    employees: [["Paris", "Hilton"], ["Kylie", "Jenner"], ["Khloé", "Kardashian"], ["Jeffree", "Star"], ["Addison", "Rae"], ["Bella", "Thorne"]],
    manager: ["Kim", "Kardashian"]
  },
  "Data" => {
    employees: [["Silvio", "Berlusconi"], ["Nicolas", "Sarkozy"], ["Richard", "Nixon"], ["Jair", "Bolsonaro"]],
    manager: ["Donald", "Trump"]
  },
  "Produit" => {
    employees: [["Cristiano", "Ronaldo"], ["Michael", "Jordan"], ["Serena", "Williams"], ["Usain", "Bolt"]],
    manager: ["Zinedine", "Zidane"]
  }
}

founders = [["Plore", "DeFaillerets"], ["Bictor", "Venhamou"], ["Nean", "Jaegelen"], ["Domain", "Recline"]]

people_count = founders.length
people_data.each do |team_name, people|
  team_count = (people[:employees].length + 1)
  people_count += team_count
end
bar = TTY::ProgressBar.new("Users :bar :percent :people", total: people_count, width: 50, complete: "█", incomplete: "░")

people_data.each do |team_name, people|
  team = Team.create!(name: team_name, organization: organization)
  first_name = people[:manager][0]
  last_name = people[:manager][1]
  email = first_name.downcase+"."+last_name.downcase+"@mistral.com"
  User.create!(first_name: first_name, last_name: last_name, email: email, password: "test12345", role: "Manager", team: team, start_date: "2024-01-01")
  bar.advance(people: first_name + " " + last_name)
  people[:employees].each do |employee|
    first_name = employee[0]
    last_name = employee[1]
    email = first_name.downcase+"."+last_name.downcase+"@mistral.com"
    User.create!(first_name: first_name, last_name: last_name, email: email, password: "test12345", role: "Employee", team: team, start_date: "2025-01-01")
    bar.advance(people: first_name + " " + last_name)
  end
end

team = Team.create!(name: "Founders", organization: organization)

founders.each do |founder|
  first_name = founder[0]
  last_name = founder[1]
  email = first_name.downcase+"."+last_name.downcase+"@mistral.com"
  User.create!(first_name: first_name, last_name: last_name, email: email, password: "test12345", role: "Founder", team: team, start_date: "2024-01-01")
  bar.advance(people: first_name + " " + last_name)
end

puts "#{Team.count} teams and #{User.count} members created!"

# TOOLS

puts "Creating tools..."

tools_data = {
    "Sellsy" => {
        short_description: "Solution française de gestion pour TPE/PME",
        long_description: "Sellsy est une plateforme française tout-en-un qui propose des outils de CRM, de facturation, de comptabilité et de gestion des stocks. Elle aide les entreprises à centraliser leurs processus commerciaux, à améliorer la relation client et à optimiser la gestion financière.",
        website: "https://www.sellsy.fr",
        logo: "https://x5h8w2v3.rocketcdn.me/wp-content/uploads/2021/01/Logo-Sellsy-1.png"
    },
    "Notion" => {
        short_description: "Outil de productivité tout-en-un",
        long_description: "Notion est une application de productivité qui combine des fonctionnalités de prise de notes, de gestion de projet, de base de données et de calendrier. Elle permet aux équipes de collaborer efficacement en centralisant les informations et en personnalisant les espaces de travail selon leurs besoins.",
        website: "https://www.notion.so",
        logo: "https://cdn.jaimelesstartups.fr/wp-content/uploads/2022/02/illustration%20%C3%A0%20propos%20de%20la%20startup%20Notion%20est%20disponible%20en%20Fran%C3%A7ais.png"
    },
    "Slack" => {
        short_description: "Plateforme de communication collaborative",
        long_description: "Slack est une plateforme de messagerie dédiée aux entreprises, facilitant la communication en temps réel entre les équipes. Elle offre des canaux thématiques, des intégrations avec divers outils professionnels et des fonctionnalités de partage de fichiers, améliorant ainsi la collaboration et la productivité.",
        website: "https://slack.com",
        logo: "https://marketplace.luccasoftware.com/wp-content/uploads/2023/01/logo_slack.png"
    },
    "Mailchimp" => {
        short_description: "Plateforme d'automatisation marketing",
        long_description: "Mailchimp est une solution complète d'automatisation du marketing, principalement axée sur l'emailing. Elle permet aux entreprises de créer des campagnes marketing, de gérer des listes de diffusion, d'analyser les performances et d'intégrer divers outils tiers pour une stratégie marketing cohérente.",
        website: "https://mailchimp.com",
        logo: "https://play-lh.googleusercontent.com/IBV0NyRdxyNlCgyWnbeZs3rkPYfNXlPJ4-rF0ok3Biox_N-GjLtMZ7Qub5HTmVZiWjg"
    },
    "HubSpot" => {
        short_description: "Logiciel de CRM et marketing inbound",
        long_description: "HubSpot est une suite logicielle offrant des outils de CRM, de marketing, de vente et de service client. Elle aide les entreprises à attirer des visiteurs, à convertir des leads et à fidéliser des clients en centralisant les données et en automatisant les processus marketing et commerciaux.",
        website: "https://www.hubspot.fr",
        logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY8swbre0cW4JzO0g3oGOGcN_-5bUU1znzPA&s"
    },
    "Canva" => {
      short_description: "Outil de design graphique en ligne",
      long_description: "Canva est une plateforme de design graphique intuitive qui permet aux utilisateurs de créer des visuels professionnels sans compétences avancées en design. Elle propose une vaste bibliothèque de modèles, d'images et d'éléments graphiques pour réaliser des présentations, des publications sur les réseaux sociaux, des affiches, etc.",
      website: "https://www.canva.com",
      logo: "https://tpc.ucf.edu/wp-content/uploads/sites/5/2024/07/canva-logo.png"
    },
    "Klaxoon" => {
        short_description: "Plateforme de collaboration visuelle",
        long_description: "Klaxoon est une solution française qui propose une suite d'outils interactifs pour faciliter la collaboration en équipe. Elle permet d'organiser des réunions, des ateliers et des sessions de brainstorming de manière engageante, favorisant ainsi la créativité et l'efficacité collective.",
        website: "https://klaxoon.com",
        logo: "https://play-lh.googleusercontent.com/g2ngouMOiae7CmJm0tlYM8ZcRBA5uxZgUY6mjC1LULk2bN5qMZ2hQ0dRIl83bcQhF3k"
    },
    "EBP" => {
        short_description: "Logiciels de gestion pour TPE/PME",
        long_description: "EBP est un éditeur français de logiciels de gestion destinés aux TPE et PME. Ses solutions couvrent des domaines tels que la comptabilité, la gestion commerciale, la paie et la facturation, aidant les entreprises à optimiser leurs processus administratifs et financiers.",
        website: "https://www.ebp.com",
        logo: "https://www.grafe.fr/wp-content/uploads/2021/01/EBP-SaaS-250x250.png"
    },
    "Monday.com" => {
        short_description: "Plateforme de gestion du travail",
        long_description: "Monday.com est une plateforme de gestion du travail qui centralise les tâches, les projets et la communication au sein d'une interface intuitive. Elle offre des fonctionnalités de suivi, de collaboration et de reporting, aidant les équipes à rester alignées et productives.",
        website: "https://monday.com",
        logo: "https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/c1/6d/dc/c16ddc8f-2e9d-9345-793e-fe28bbdceaf3/icon.png/1200x630bb.png"
    },
    "Zoho CRM" => {
        short_description: "Solution complète de gestion de la relation client",
        long_description: "Zoho CRM est un logiciel qui aide les entreprises à gérer leurs interactions avec les clients, à automatiser les processus de vente et à analyser les performances. Il offre une gamme complète de fonctionnalités pour améliorer la satisfaction client et augmenter les ventes.",
        website: "https://www.zoho.com/crm",
        logo: "https://cloud-store.fr/wp-content/uploads/2023/09/zoho_logo_icon_169675.png"
    },
    "Qonto" => {
        short_description: "Compte pro en ligne pour PME et indépendants",
        long_description: "Qonto est une néobanque française dédiée aux professionnels, offrant des services bancaires en ligne adaptés aux besoins des PME, des startups et des indépendants. Elle propose une interface intuitive, des outils de gestion financière intégrés et un service client réactif pour simplifier la gestion quotidienne des finances.",
        website: "https://qonto.com",
        logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6ywk1lexb3mf3G0EAQ_skX_AoA2arJyuzWA&s"
    },
    "PayFit" => {
        short_description: "Solution de gestion de la paie et des ressources humaines",
        long_description: "PayFit est une plateforme française qui automatise la gestion de la paie et des ressources humaines pour les entreprises. Elle permet de gérer facilement les bulletins de salaire, les congés, les absences et les déclarations sociales, tout en garantissant la conformité aux réglementations en vigueur.",
        website: "https://payfit.com",
        logo: "https://media.licdn.com/dms/image/v2/C560BAQG8enVUlIaAwA/company-logo_200_200/company-logo_200_200/0/1630584148492/payfit_logo?e=2147483647&v=beta&t=tlg5N94TTRQxf-v0ZVlF61pP87NQzhcFHNcFtUturrE"
    },
    "Spendesk" => {
        short_description: "Gestion des dépenses d'entreprise simplifiée",
        long_description: "Spendesk est une solution tout-en-un pour gérer les dépenses professionnelles, incluant les paiements, les notes de frais et les abonnements. Elle offre une visibilité en temps réel sur les dépenses, des cartes virtuelles et physiques pour les employés, et une intégration avec les logiciels de comptabilité.",
        website: "https://www.spendesk.com",
        logo: "https://play-lh.googleusercontent.com/xBLbEvLM063kV_ZSch5jBZ8b6zYaLvU2PLsXnwU23-6QKlNZsXZHc8Euiz1m4eyfLA"
    },
    "Alan" => {
        short_description: "Assurance santé pour entreprises et indépendants",
        long_description: "Alan est une compagnie d'assurance santé française 100% en ligne, offrant des couvertures simples et transparentes pour les entreprises et les indépendants. Elle propose une gestion simplifiée des remboursements, une application mobile conviviale et un service client réactif.",
        website: "https://alan.com",
        logo: "https://adopte.co/wp-content/uploads/2023/01/logo-alan.png"
    },
    "Swile" => {
      short_description: "Carte titres-restaurants et avantages salariés",
      long_description: "Swile propose une carte intelligente regroupant les titres-restaurants, les cadeaux d'entreprise et d'autres avantages salariés. Elle facilite la gestion des avantages sociaux pour les employeurs et offre une expérience moderne et flexible aux employés.",
      website: "https://www.swile.co",
      logo: "https://s3-eu-west-1.amazonaws.com/tpd/logos/5f86f0223251450001dafec9/0x0.png"
    },
    "Legalstart" => {
        short_description: "Services juridiques en ligne pour entrepreneurs",
        long_description: "Legalstart est une plateforme française qui simplifie les démarches juridiques pour les entrepreneurs et les PME. Elle offre des services tels que la création d'entreprise, la rédaction de contrats et des conseils juridiques, le tout en ligne et à des tarifs compétitifs.",
        website: "https://www.legalstart.fr",
        logo: "https://www.legalstart.fr/hubfs/Favicon_Legalstart-1.png"
    },
    "Aircall" => {
        short_description: "Système de téléphonie cloud pour entreprises",
        long_description: "Aircall est une solution de téléphonie cloud conçue pour les équipes de support et de vente. Elle s'intègre facilement aux outils CRM et helpdesk, offrant des fonctionnalités avancées telles que la gestion des appels, les files d'attente et les analyses en temps réel.",
        website: "https://aircall.io",
        logo: "https://cdn.prod.website-files.com/62d4335c49ba53481bdf4fbf/630146f6684f52c4df294af9_Aircall_-_VoIP_Business_Phone_-_Apps_on_Google_Play.png"
    },
    "Front" => {
        short_description: "Plateforme collaborative de gestion des emails",
        long_description: "Front est une application qui transforme la gestion des emails en une expérience collaborative. Elle permet aux équipes de partager et de gérer ensemble les boîtes de réception, d'assigner des messages et de collaborer en temps réel pour améliorer la réactivité et la satisfaction client.",
        website: "https://frontapp.com",
        logo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSaff532w3LLlBpvnzraZSU0JQJo-ecBTkXg&s"
    },
    "Livestorm" => {
        short_description: "Plateforme de webinaires et de réunions en ligne",
        long_description: "Livestorm est une solution française pour organiser des webinaires, des démonstrations de produits et des réunions en ligne. Elle offre une interface intuitive, des outils d'engagement pour les participants et des analyses détaillées pour mesurer l'impact des événements.",
        website: "https://livestorm.co",
        logo: "https://cdn.livestorm.co/uploads/organization/avatar/61ec6e9f-8953-49ce-bf8f-865172120592/a67e33ba-10e3-4c3a-9d96-b667d3237308.png?v=1678184380"
    },
    "Sendinblue" => {
        short_description: "Plateforme d'email marketing et de communication",
        long_description: "Sendinblue est une solution complète pour gérer les campagnes d'email marketing, les SMS, le chat et l'automatisation marketing. Elle aide les entreprises à engager leur audience, à personnaliser leurs communications et à analyser les performances pour optimiser les stratégies marketing.",
        website: "https://fr.sendinblue.com",
        logo: "https://www.skysnag.com/wp-content/uploads/2022/06/Sendinblue.png"
    },
    "Airtable" => {
        short_description: "Base de données intuitive combinant les fonctionnalités d’un tableur et d’un CRM",
        long_description: "Airtable est un outil collaboratif qui combine la simplicité d’un tableur avec la puissance d’une base de données relationnelle. Il permet aux équipes de structurer et d'organiser leurs données de manière flexible grâce à des vues personnalisables (grille, kanban, calendrier, galerie). Avec Airtable, les utilisateurs peuvent créer des workflows sur mesure, automatiser des tâches et intégrer l’outil à d’autres applications populaires comme Slack, Google Sheets ou Notion. Son interface intuitive permet une adoption rapide, aussi bien pour les petites entreprises que pour les grandes organisations.",
        website: "https://www.airtable.com/",
        logo: "https://www.podfeet.com/blog/wp-content/uploads/2018/05/airtable-logo-1.png"
    },
    "Make" => {
        short_description: "Plateforme avancée d'automatisation visuelle pour connecter et orchestrer des workflows complexes",
        long_description: "Make est une plateforme d'automatisation puissante qui permet aux utilisateurs de créer des flux de travail complexes en connectant des applications et en manipulant des données de manière flexible. Contrairement à Zapier, Make offre un éditeur visuel qui permet de concevoir des scénarios d’automatisation avancés avec des conditions, des boucles et des transformations de données. L’outil prend en charge des centaines d’intégrations natives (Google Sheets, Airtable, Slack, Notion, Shopify…) et permet également d’interagir avec des API via des requêtes HTTP. C’est une solution prisée par les entreprises cherchant à automatiser des processus plus sophistiqués et personnalisés.",
        website: "https://www.make.com/en/product",
        logo: "https://media.licdn.com/dms/image/v2/D4D0BAQHnCozggmmIlg/company-logo_200_200/company-logo_200_200/0/1711022203215/itsmakehq_logo?e=2147483647&v=beta&t=29Xz2B2VIMTWeP3lXYnNTnk1pbag0SPXMOXWrAghHU8"
    },
    "Stripe" => {
        short_description: "Solution de paiement en ligne sécurisée et performante pour entreprises",
        long_description: "Stripe est une plateforme de paiement en ligne permettant aux entreprises d’accepter des paiements par carte bancaire, virement ou portefeuille électronique en toute simplicité. Conçue pour les développeurs, elle offre une API robuste qui facilite l'intégration des paiements dans les sites web et applications. Stripe propose aussi des fonctionnalités avancées comme la gestion des abonnements, les paiements internationaux, la détection de fraudes et des outils analytiques pour optimiser la conversion. Adoptée par des milliers d’entreprises à travers le monde, Stripe est une solution idéale pour les startups, PME et grandes entreprises cherchant à gérer efficacement leurs transactions en ligne.",
        website: "https://stripe.com/fr/payments",
        logo: "https://play-lh.googleusercontent.com/2PS6w7uBztfuMys5fgodNkTwTOE6bLVB2cJYbu5GHlARAK36FzO5bUfMDP9cEJk__cE"
    },
    "Hotjar" => {
      short_description: "Outil d’analyse de l’expérience utilisateur avec cartes de chaleur et enregistrements de sessions",
      long_description: "Hotjar est une solution d’analyse comportementale qui permet aux entreprises de mieux comprendre comment les utilisateurs interagissent avec leur site web. Grâce à des cartes de chaleur (heatmaps), des enregistrements de sessions et des enquêtes utilisateurs, Hotjar offre une vision claire des points d'amélioration et des obstacles rencontrés par les visiteurs. L’outil est particulièrement utile pour optimiser l’expérience utilisateur, améliorer les taux de conversion et affiner les stratégies UX/UI en s’appuyant sur des données concrètes. Hotjar est plébiscité par les équipes marketing, produit et UX pour prendre des décisions éclairées basées sur le comportement réel des utilisateurs.",
      website: "https://www.hotjar.com/fr/",
      logo: "https://cdn1.oxatis.com/Files/112496/Img/23/Logo-Apps-Hotjar-600px.png"
    },
    "Tableau" => {
        short_description: "Logiciel puissant de visualisation et d’analyse de données pour les entreprises",
        long_description: "Tableau est une plateforme de Business Intelligence (BI) qui permet de transformer des données complexes en visualisations interactives et dynamiques. Grâce à son interface intuitive et ses puissantes capacités d’analyse, Tableau aide les entreprises à explorer leurs données, identifier des tendances et prendre des décisions stratégiques éclairées. Compatible avec une multitude de sources de données (Excel, SQL, Google Analytics, CRM…), Tableau est utilisé par les analystes et les dirigeants pour piloter la performance de leur entreprise en temps réel. Sa version cloud, Tableau Online, permet un accès collaboratif aux tableaux de bord, facilitant ainsi le partage des insights au sein des équipes.",
        website: "https://www.tableau.com/",
        logo: "https://logo-marque.com/wp-content/uploads/2021/10/Tableau-Symbole.jpg"
    },
    "Power BI" => {
        short_description: "Outil de Business Intelligence développé par Microsoft pour analyser et visualiser des données",
        long_description: "Power BI est une suite d’outils analytiques développée par Microsoft, permettant de transformer des données brutes en tableaux de bord interactifs et en rapports visuels. Intégré à l’écosystème Microsoft (Excel, Azure, SQL Server…), Power BI facilite l’importation et le traitement de données provenant de sources multiples. Son interface glisser-déposer et son langage DAX permettent de créer des analyses avancées sans nécessiter de compétences en programmation. Accessible en version desktop, cloud ou mobile, Power BI est un choix privilégié pour les entreprises souhaitant exploiter leurs données pour prendre des décisions stratégiques basées sur des insights précis et visuels.",
        website: "https://www.microsoft.com/en-us/power-platform/products/power-bi",
        logo: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/New_Power_BI_Logo.svg/1200px-New_Power_BI_Logo.svg.png"
    },
    "GitHub" => {
      short_description: "Plateforme de gestion de versions et de collaboration pour les développeurs.",
      long_description: "GitHub est une plateforme de développement collaboratif basée sur Git, permettant aux développeurs de gérer leurs projets, suivre les modifications du code et collaborer efficacement. Grâce à ses fonctionnalités de contrôle de versions, de gestion des pull requests et d'intégration continue, GitHub est un outil clé pour les équipes de développement logiciel. Il offre également un espace d’hébergement pour les dépôts publics et privés, ainsi qu’une large gamme d’outils pour l’automatisation, la sécurité et la documentation des projets. Avec une communauté mondiale de millions de développeurs, GitHub favorise l'open source et l'innovation en facilitant le partage et l’amélioration du code à grande échelle.",
      website: "https://github.com/",
      logo: "https://download.logo.wine/logo/GitHub/GitHub-Logo.wine.png"
    }
}

tools_count = tools_data.size
bar = TTY::ProgressBar.new("Tools :bar :percent - :tool", total: tools_count, width: 50, complete: "█", incomplete: "░")

tools_data.each do |name, properties|
  tool = Tool.create!(name: name, category: Tool::CATEGORIES.sample, description: properties[:short_description], long_description: properties[:long_description], website: properties[:website])
  if cloudinary_storage
    begin
      file = URI.open(properties[:logo])
      tool.logo.attach(io: file, filename: "default_logo.jpg", content_type: "image/jpeg")
    rescue OpenURI::HTTPError, Errno::ENOENT => e
      puts "⚠️ Erreur lors du téléchargement du logo"
      next
    end
  end
  bar.advance(tool: name)
end


puts "#{Tool.count} tools created!"

# REVIEWS

puts "Creating reviews..."

Tool.all.each do |tool|
  10.times do
    review = Review.create(username: "#{Faker::Name.first_name}#{Faker::Name.last_name}",content: Faker::Quotes::Shakespeare.hamlet_quote,rating: (0..5).to_a.sample, tool: tool)
  end
end

puts "#{Review.count} reviews created!"


# PLANS

puts "Creating plans..."


tool_names = Tool.all.pluck(:name)
first_tool_names = tool_names.first(20)
unless first_tool_names.include?("GitHub")
  first_tool_names.push("GitHub")
end
unless first_tool_names.include?("Airtable")
  first_tool_names.push("Airtable")
end

Tool.where(name: first_tool_names).each do |tool|
  Plan.create!(organization: organization, tool: tool, formula: JSON.parse(tool.formulas).to_a.sample, status: "Approved")
end

puts "#{Plan.count} plans created!"

# SCOPES

puts "Creating scopes..."

tools_to_exclude = Tool.where(name: ["GitHub","Airtable"]).pluck(:id)
plans_to_scope = Plan.where.not(tool_id: tools_to_exclude).pluck(:id)

Team.all.each do |team|
  plans = plans_to_scope.dup
  (6..12).to_a.sample.times do
    plan = plans.sample
    Scope.create!(team: team, plan: Plan.find(plan))
    plans.delete(plan)
  end
end

tech_team = Team.where(name: "Tech").first
github_tool = Tool.where(name: "GitHub").first
github_plan = Plan.where(tool: github_tool).first
Scope.create!(team: tech_team, plan: github_plan)

puts "#{Scope.count} scopes created!"


# LICENSES

puts "Creating licenses..."

Scope.all.each do |scope|
  scope.team.users.each do |user|
    License.create!(user: user, scope: scope, plan: scope.plan, start_date: "2025-01-01", end_date: "2026-01-01", status: "Approved", access_type: "User")
  end
end

puts "next"

Team.where(name: "Sales").first.users.each do |user|
  ["Declined","Pending"].each do |status|
    airtable_tool = Tool.where(name: "Airtable").first
    airtable_plan = Plan.where(tool: airtable_tool).first
    License.create!(user: user, plan: airtable_plan, start_date: "2025-01-01", end_date: "2026-01-01", status: status, access_type: "User")
  end
end

puts "#{License.count} licenses created!"
