module DocumentsHelper
  
  #truncate the long parts of a fileame
  def truncate_filename(filename)
    filename.split('.').map { |chunk| truncate(chunk, :length => 25, :omission => '&hellip;')}.join('.')
  end
end
