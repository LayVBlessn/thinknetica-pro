class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attach = ActiveStorage::Attachment.find(params[:id])
    
    if current_user.author_of?(@attach.record)
      @attach.purge
    end
  end
end
