# Copyright:: (c) Autotelik Media Ltd 2012
# Author ::   Tom Statter
# Date ::     June 2012
# License::   MIT. Free, Open Source.
#
# => Provides facilities for bulk uploading/exporting attachments provided by PaperClip 
# gem
require 'datashift_paperclip'
require 'attachment_loader'

module DataShift

  module ImageLoading
 
    include DataShift::Paperclip 

    
    # Note the paperclip attachment model defines the storage path via something like :
    # 
    # => :path => ":rails_root/public/blah/blahs/:id/:style/:basename.:extension"
    # 
    # Options 
    # 
    #   See also DataShift::paperclip create_attachment for more options
    #   
    #   Example:  Image is a model class with an attachment.
    #             Image table contains a viewable field which can contain other  models,
    #             such as Product, User etc all of which can have an Image
    #             
    #   :viewable_record 
    #   
    def create_attachment(klass, attachment_path, record = nil, attach_to_record_field = nil, options = {})
        
      image_attributes = { :attributes => 
                            { :alt => (options[:alt] || ""),
                              :position => (!options[:position] && record and record.respond_to?(:images)) ? record.images.length : 0
                            }
      }

      attachment_options = options.dup.merge(image_attributes)
      
      #puts "DEBUG : create_attachment options : #{attachment_options.inspect}"
       
      super(klass, attachment_path, record, attach_to_record_field, attachment_options)
    end
    
    # Set of file extensions ImageMagik can process so default glob
    # we use to find image files within directories
    def self.image_magik_glob
      @im_glob ||= %w{*.3FR *.AAI *.AI *.ART *.ARW  *.AVI *.AVS *.BGR *.BGRA
                  *.BIE *.BMP *.BMP2  *.BMP3  *.BRF *.CAL *.CALS *.CANVAS
                  *.CIN *.CIP *.CLIP *.CMYK *.CMYKA *.CR2 *.CRW *.CUR *.CUT *.DCM *.DCR *.DCX
                  *.DDS *.DFONT *.DJVU *.DNG  *.DOT *.DPS *.DPX
                  *.EMF *.EPDF  *.EPI *.EPS *.EPS2 *.EPS3  *.EPSF *.EPSI
                  *.EPT *.EPT2 *.EPT3 *.ERF *.EXR *.FITS *.FPX  *.FTS *.G3 *.GIF *.GIF87
                  *.GRAY *.HALD  *.HDR *.HRZ  *.ICB *.ICO *.ICON *.IPL
                  *.ISOBRL *.J2C *.JBG  *.JBIG *.JNG *.JP2 *.JPC *.JPEG *.JPG *.JPX  *.K25 *.KDC
                  *.LABEL *.M2V  *.M4V  *.MAC *.MAP  *.MAT *.MATTE *.MIFF *.MNG  *.MONO
                  *.MOV *.MP4 *.MPC *.MPEG *.MPG *.MRW *.MSL *.MSVG *.MTV *.MVG *.NEF *.ORF *.OTB *.OTF *.PAL *.PALM
                  *.PAM *.PBM  *.PCD *.PCDS *.PCL *.PCT *.PCX *.PDB *.PDF *.PDFA  *.PEF
                  *.PES *.PFA *.PFB *.PFM *.PGM  *.PGX *.PICON *.PICT *.PIX *.PJPEG *.PLASMA
                  *.PNG *.PNG24  *.PNG32 *.PNG8 *.PNM *.PPM *.PS *.PS2 *.PS3 *.PSB *.PSD *.PTIF *.PWP *.RAF *.RAS *.RGB
                  *.RGBA *.RGBO *.RLA *.RLE *.SCR *.SCT *.SFW *.SGI *.SR2 *.SRF
                  *.SUN *.SVG *.SVGZ *.TGA *.TIFF *.TIFF64 *.TILE *.TIM *.TTC *.TTF *.UBRL *.UIL *.UYVY *.VDA  *.VICAR
                  *.VID *.VIFF  *.VST *.WBMP *.WEBP  *.WMF *.WMV *.WMZ *.WPG  *.X3F
                  *.XBM *.XC *.XCF *.XPM *.XPS *.XV *.XWD *.YCbCr *.YCbCrA *.YUV
      }
      "{#{@im_glob.join(',')}}"
    end
  end
      
end
