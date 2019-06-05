class TweetsController < ApplicationController

  get '/tweets/new' do
    if logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:tweet][:content].empty?
      redirect '/tweets/new'
    else
    current_user.tweets.create(params[:tweet])
    #binding.pry
    redirect '/tweets'
  end
end


  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = current_user.tweets
      #binding.pry
      erb :'/tweets/tweets'
    else
      redirect '/login'
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
    @tweet = Tweet.find(params[:id])
    if logged_in? #&& current_user.tweets.include?(@tweet)
      erb :'/tweets/edit'
    else
      #binding.pry
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    if params[:tweet][:content].empty?
      redirect "/tweets/#{params[:id]}/edit"
    else
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
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
