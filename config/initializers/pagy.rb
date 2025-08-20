# config/initializers/pagy.rb

# Pagy initializer file
# Customize your Pagy global default settings here
# For more info visit: https://ddnexus.github.io/pagy/docs/api/pagy
# For a quick cheat sheet visit: https://ddnexus.github.io/pagy/docs/extras/cheat-sheet

# Extras
# See https://ddnexus.github.io/pagy/docs/extras
# To require an extra, uncomment the line below.
# You can also require the extras in your models or controllers

require 'pagy/extras/metadata'
require 'pagy/extras/overflow'

# :empty_page -> Retorna uma página vazia sem levantar erro.
# :last_page  -> Retorna a última página válida.
# :exception  -> Levanta o erro Pagy::OverflowError (default).
Pagy::DEFAULT[:overflow] = :empty_page

# Set the default items per page
Pagy::DEFAULT[:items] = 20