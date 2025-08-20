# config/initializers/pagy.rb

# Pagy initializer file
# Customize your Pagy global default settings here
# For more info visit: https://ddnexus.github.io/pagy/docs/api/pagy
# For a quick cheat sheet visit: https://ddnexus.github.io/pagy/docs/extras/cheat-sheet

# Extras
# See https://ddnexus.github.io/pagy/docs/extras
# To require an extra, uncomment the line below.
# You can also require the extras in your models or controllers

# IMPORTANT: Este extra é necessário para a sua API funcionar com o helper `pagy_metadata`
require 'pagy/extras/metadata'

# When you are done customizing your pagy initializer,
# you can safely delete this comment block.

# Set the default items per page
Pagy::DEFAULT[:items] = 20