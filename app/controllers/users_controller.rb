class UsersController < ApplicationController

  get '/' do
    erb :'/users/index'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    #binding.pry
    user = User.new(params)
    if !user.save || user.username == "" || user.email == ""
      redirect '/signup'
    else
      user.save
      session[:user_id] = user.id

      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'/users/login'
  end
end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      #binding.pry
      redirect '/tweets'
    else
      redirect '/signup'
  end
  end


  get '/logout' do #where to connect?
    session.clear
    redirect '/login'
  end

  get '/users/:username' do
      @tweets = User.find_by(username: [:username]).tweets
      erb :'/tweets/view'
    end
end
