require "paperclip"

module Paperclip
  class CaptionProcessor < Processor

    def initialize file, options = {}, attachment = nil
      super

      @file             = file
      @format           = options[:format]
      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode

      begin
        parameters = []
        parameters << caption_options
        parameters << caption
        parameters << ":source"
        parameters << "+swap"
        parameters << "-gravity center"
        parameters << "-composite"
        parameters << ":dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

        success = convert(parameters, source: "#{File.expand_path(src.path)}[0]", dest: File.expand_path(dst.path))
      rescue Cocaine::ExitStatusError => e
        raise Paperclip::Error, "There was an error processing caption for #{@basename}" if @whiny
      rescue Cocaine::CommandNotFoundError => e
        raise Paperclip::Errors::CommandNotFoundError.new("Could not run the `convert` command. Please install ImageMagick.")
      end

      dst
    end

    protected

    def caption_options
      opts = []
      opts << caption_background
      opts << font_color
      opts << line_height
      opts << letter_spacing
      opts << word_spacing
      opts << position
      opts << caption_size
      opts << font
      opts
    end

    def caption_background
      "-background #{background_color}"
    end

    def background_color
      @options[:caption_background] || "none"
    end

    def font_color
      "-fill #{@options[:font_color]}" if @options[:font_color]
    end

    def font
      "-font #{@options[:font]}" if @options[:font]
    end

    def caption
      "caption:'#{@options[:caption] || ""}'"
    end

    def position
      "-gravity #{@options[:position] || "center"}"
    end

    def letter_spacing
      "-kerning #{@options[:kerning] || 1.5}"
    end

    def word_spacing
      "-interword-spacing #{@options[:interword_spacing] || 5}"
    end

    def line_height
      "-interline-spacing  #{@options[:interline_spacing] || 18}"
    end

    def caption_size
      "-size #{caption_width}X#{caption_height}"
    end

    def caption_width
      width = @options[:geometry].split(/[^\d+]/).first.to_i
      width -= @options[:padding_width] if @options[:padding_width]
      width
    end

    def caption_height
      height = @options[:geometry].split(/[^\d+]/).last.to_i
      height -= @options[:padding_height] if @options[:padding_height]
      height
    end
  end
end

