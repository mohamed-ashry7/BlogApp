module Api


    class CommentsController < ApplicationController

        before_action :authorized
        before_action :same_user ,only: [:update,:destroy]

        def index 

            @comments = Post.find(params[:post_id]).comments
            render json: {comments: comments }
            # render json: {msg: "Comments"}

        end

        def create
            @post = Post.find(params[:post_id])
            @tag = @post.comments.create(params.permit(:comment))
            render json: {comments: @post.comments}
        end


        def destroy
            @post = Post.find(params[:post_id])
            @comment = @post.comments.find(params[:id])
            @comment.destroy
            render json: {comment: @comment }
        end

        def get_id
            Comment.find(params[:id]).user_id
        end

        def same_user
            render json: { message: 'You are not authorized' }, status: :unauthorized unless @user.id == get_id
        end

    end
    
end