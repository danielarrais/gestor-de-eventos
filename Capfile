require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano3/unicorn'

install_plugin Capistrano::SCM::Git

Dir.glob("lib/tasks/capistrano/*.rake").each { |r| import r }