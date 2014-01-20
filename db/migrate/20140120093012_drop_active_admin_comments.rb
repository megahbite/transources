require_relative '20130628025611_move_admin_notes_to_comments'
require_relative '20130628025610_create_admin_notes'

class DropActiveAdminComments < ActiveRecord::Migration
  def change
    revert MoveAdminNotesToComments
    revert CreateAdminNotes
  end
end
