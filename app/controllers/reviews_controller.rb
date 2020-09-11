class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.update(title: 'タイトル記載なし') if @review.title.blank?
    @review.update(content: 'コメント記載なし') if @review.content.blank?
    if @review.save
      flash[:success] = 'レビューを投稿しました！ご協力ありがとうございます！'
      redirect_to reviews_path
    else
      flash[:danger] = 'レビューに失敗しました、お手数ですが再度お試しください'
      render 'reviews/new'
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(title: params[:review][:title], content: params[:review][:content], rate: params[:review][:rate])
      flash[:success] = 'レビュー内容を変更しました'
      redirect_to reviews_path
    else
      flash[:danger] = 'レビュー内容を変更出来ませんでした、お手数ですが再度お試しください'
      render 'reviews/edit'
    end
  end

  def destroy
    Review.find_by(id: params[:id]).delete
    flash[:success] = 'レビューを削除しました'
    redirect_to request.referrer || root_url
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rate)
  end
end
