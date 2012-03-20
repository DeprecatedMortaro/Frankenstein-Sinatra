#coding: utf-8 
require 'sinatra'
require 'frankenstein-sinatra'

get '/' do
  haml :index
end