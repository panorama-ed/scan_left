source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in scan_left.gemspec
gemspec

group :development do
  if RUBY_VERSION.start_with?("2.7")
    # Match only Ruby version we run the linters on in CI
    gem "panolint", github: "panorama-ed/panolint"
  end
end
