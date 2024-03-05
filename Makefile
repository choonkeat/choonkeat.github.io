serve: vendor/bundle
	bundle exec jekyll serve

vendor/bundle: Gemfile
	bundle install --path vendor/bundle
