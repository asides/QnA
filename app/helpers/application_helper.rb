module ApplicationHelper
  # Public: Pick the correct arguments for form_for when shallow routes
  # are used.
  #
  # parent - The Resource that has_* child
  # child - The Resource that belongs_to parent.
  def shallow_args(parent, child)
    params[:action] == 'new' ? [parent, child] : child
  end

end
