require_relative 'product'

class Disk < Product
  attr_accessor :title, :singer, :genre, :year

  def self.from_file(path)
    lines = File.readlines("#{path}", chomp: true)
    new(
      title: lines[0],
      singer: lines[1],
      genre: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5]
    )
  end

  def initialize(params)
    super
    @title = params[:title]
    @singer = params[:singer]
    @genre = params[:genre]
    @year = params[:year]
  end

  def info
    "Альбом #{@singer} — «#{@title}», #{@genre}, #{@year} год"
  end

  def update(params)
    super

    @title = params[:title] if params[:title]
    @year = params[:year] if params[:year]
    @singer = params[:singer] if params[:singer]
    @year = params[:year] if params[:year]
  end
end
