class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      #binding.pry
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content].empty?
      redirect '/tweets/new'
    else
    current_user.tweets.create(content: params[:content])
    #binding.pry
    redirect '/tweets'
  end
end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      if @tweet = Tweet.find(params[:id]) && current_user.tweets.include?(@tweet)
      erb :'/tweets/edit'
      else
      redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    if params[:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])
    redirect "/tweets/#{params[:id]}"
  end
end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if logged_in? && current_user.tweets.include?(@tweet)
      Tweet.delete(params[:id])
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
