class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reviews, only: [:edit,:update,:destroy]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.update(title: "タイトル記載なし") if @review.title.blank?
    @review.update(content: "コメント記載なし") if @review.content.blank?
    if @review.save
      flash[:success] = "レビューを投稿しました！ご協力ありがとうございます！"
      redirect_to reviews_path
    else
      flash[:danger] = "無効な処理です、お手数ですが再度お試しください"
      render "reviews/new"
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] = "レビュー内容を変更しました"
      redirect_to reviews_path
    else
      flash[:danger] = "レビュー内容を変更出来ませんでした、お手数ですが再度お試しください"
      render "reviews/edit"
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = "レビューを削除しました"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "無効な処理です、お手数ですが再度お試しください"
    end
  end

  private

  def set_reviews
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :rate)
  end
end
