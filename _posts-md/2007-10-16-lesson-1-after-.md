---
layout: post
title: 'Lesson #1 after using the iPhone: Automatic Orientation'
published: true
category:
- ruby
---
Remember those days of downloading your photos from your camera, then going through them, one by one... and rotating each picture right-side up until you get drowsy or give up? Such tedious work! Oh, and did you click save after you rotated?

Apparently, pictures taken from the iPhone and many new digital cameras (though none from [the world's largest camera manufacturer](http://www.google.com/search?esrch=BetaShortcuts&q=is%20the%20World's%20largest%20camera%20manufacturer)) comes embedded with orientation information! To put it simply, it means that these digital photos already know if they are landscape or portrait - How cool is that?

Unfortunately, not all software makes use of this piece of information to save you the labor. And [this includes even cool sites like Flickr](http://flickr.com/photos/choonkeat/tags/orientation/) :-( What a shame. And it doesn't help that most image upload/resize/crop HOWTOs doesn't talk about it either.

[SharedCopy](http://sharedcopy.com/) is cooler than that. Though imaging is not our forte, and its just done for your little profile picture, things are set up such that your profile picture will be right-side up :-D And now, with the help of some monkey-patching, your Rails/Ruby-powered website can be as cool too!

[RMagick](http://rmagick.rubyforge.org/) users, simply include the code below (e.g. append to config/environment.rb):

    require 'RMagick' unless defined?(Magick)
    Magick::Image.class\_eval do
     class \<\< self
      def read\_with\_auto\_upright(\*args, &block)
      self.read\_without\_auto\_upright(\*args, &block).collect do |img|
       begin
        # if there's nothing to rotate, auto\_orient! will return nil
        img.auto\_orient! || img
       rescue NotImplementedError
        # Older versions of ImageMagick has no auto\_orient!
        case img.get\_exif\_by\_entry("Orientation") && img["EXIF:Orientation"]
        # img["EXIF:Orientation"] might not be ready until get\_exif\_by\_entry() is called
        when "6"
        # Magick::RightTopOrientation
        img.rotate!(90)
        img["EXIF:Orientation"] = "1"
        when "3"
        # Magick::BottomRightOrientation
        img.rotate!(180)
        img["EXIF:Orientation"] = "1"
        when "8"
        # Magick::LeftBottomOrientation
        img.rotate!(270)
        img["EXIF:Orientation"] = "1"
        end
        img
       end
      end
      end
    
      # wrap around RMagick::Image#read method so that 
      # any images loaded in memory are already upright
      alias :read\_without\_auto\_upright :read
      alias :read :read\_with\_auto\_upright
      # note: not using alias\_method\_chain so that this
      #   snippet can be used outside of Rails  
     end
    end

[ImageScience](http://seattlerb.rubyforge.org/ImageScience.html) users, if you trust my C++ code, just place [this patched image\_science.rb](http://pastie.caboo.se/107610) in your vendor/ directory. Otherwise you can apply this patch manually:

    --- lib/image\_science.rb2007-10-16 12:11:08.000000000 +0800
    +++ lib/image\_science.rb.new2007-10-16 12:11:01.000000000 +0800
    @@ -150,6 +150,21 @@
        VALUE result = Qnil;
        int flags = fif == FIF\_JPEG ? JPEG\_ACCURATE : 0;
        if (bitmap = FreeImage\_Load(fif, input, flags)) {
    +    FITAG \*tagValue = NULL;
    +    FreeImage\_GetMetadata(FIMD\_EXIF\_MAIN, bitmap, "Orientation", &tagValue); 
    +    switch (tagValue == NULL ? 0 : \*((short \*) FreeImage\_GetTagValue(tagValue))) {
    +     case 6:
    +      bitmap = FreeImage\_RotateClassic(bitmap, 270);
    +      break;
    +     case 3:
    +      bitmap = FreeImage\_RotateClassic(bitmap, 180);
    +      break;
    +     case 8:
    +      bitmap = FreeImage\_RotateClassic(bitmap, 90);
    +      break;
    +     default:
    +     break;
    +    }
         result = wrap\_and\_yield(bitmap, self, fif);
        }
        return result;

What's done here (for both) is that images loaded into memory will be checked for orientation information _and have its orientation corrected if possible_ (otherwise its left untouched). In memory. So all your image operations like "width", "resize" will be magically "correct".

No modifications required to your routine. Heck, you can even pretend the whole scenario never existed!

