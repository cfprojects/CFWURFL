Download --

The CFWURFL is a Cold Fusion wrapper around the Java implementation of the WURFL.
 
As such, it still needs the WURFL JAR file and the latest WURFL XML file from Sourceforge. You can get them from:

http://sourceforge.net/projects/wurfl/files/

Download the WURFL latest and  WURFL Java API JAR. You will also need the WURFL patch(es) file from:

http://wurfl.sourceforge.net/

Click on Web Patch in the top left corner.

Installation --

The WURFL Java API JAR file has to be put into the Cold Fusion root at:

{CF Install}/lib

Once copied to this location, Cold Fusion needs to be restarted to pick up the JAR file.

In addiiton, if you will have other files in the patch directory than the patch file, the FileExtensionFilter.class file needs to be copied to:

{CF Install}/wwwroot/WEB-INF/classes

If you will only have patch files in the patch directory, this file is not needed.

Once the JAR file and the optional FileExtensionFilter have been put in the correct place and Cold Fusion has been restarted, you may now instantiate and use the CFC.

The WURFL latest file can either be unzipped, or the Java API can actually use the file in it's compressed state. The patch file should be in its own directory. You can put other files in the directory if you choose, but you must use the FileExtensionFilter if you do. The CFC assumes that you are using the FileExtensionFilter, but it can be commented out on line 53. 

Once the latest WURFL and the patch file have been copied to a Cold Fusion accessible patch, you may instantiate the CFC by providing the absolute path to both the latest WURFL file and the patch file.

Given the following directory structure:

- Websites
  - CFCs
    -cfwurfl.cfc
  - wurfl
    -wurfl-latest.zip
    - patch
      -web_browsers_patch.xml
  - index.cfm

In index.cfm, you can instantiate the CFC by passing the absolute path to both the latest WURFL file and the absolute path to the patches directory:

<cfset wurflLocation = GetDirectoryFromPath(ExpandPath("*.*")) & "wurfl-latest.zip" />
<cfset patchesLocation = GetDirectoryFromPath(ExpandPath("*.*")) & "patches" />

<cfset wurfl = createObject("component","CFCs.cfwurfl").init(wurflLocation,patchesLocation) />

Once the CFC has been instantiated, you can now get the capabilities about the browser by sending the browser agent string and the capability you're looking for. If you don't know the capability, or want all the capabilities, you can not send the second argument. 
A list of the valid capabilities you can request is at http://wurfl.sourceforge.net/help_doc.php or at the bottom of this document.

<cfset thisBrowser = wurfl.getCapability(CGI.HTTP_USER_AGENT,"resolution_width") /> to get the width of the device.

<cfset allInfo = wurfl.getCapability(CGI.HTTP_USER_AGENT) /> to get all of the informaiton about the device.

You can also get the preferred markup of the device:

<cfset preferredMarkup = wurfl.getMarkup(CGI.HTTP_USER_AGENT) />

Release --

This is the first release of this code. Hate it? What would make you hate it less? Send me feedback, submit a bug report, or start a new threadon the CFWURFL RIAForge page at http://cfwurfl.riaforge.org.

Capabilities --

Here are the capabilities you can ask the WURFL about a device, taken from http://wurfl.sourceforge.net/help_doc.php:

Group:product_info (human readable brand and model name and other generic info)
Capability Name 					Type 	Description
brand_name						string	Brand (ex: Nokia)
model_name						string	Model (ex: N95)
marketing_name					string	In addition to Brand and Model, some devices have a marketing name (for ex: BlackBerry 8100 Pearl, Nokia 8800 Scirocco, Samsung M800 Instinct).
model_extra_info					string	In addition to Brand and Model (and possibly a marketing name), some may be characterized by extra info (es: Nokia N95 8GB, Sharp 902SH Vodafone).
unique							true/false	UA is repetead for different devices (rare, but deadly occurence)
ununiqueness_handler					String	How to handle a non-unique User-agent String (API/framework may support specific mechanism to handle HTTP request directly)
is_wireless_device					true/false	Tells you if a device is wireless or not. Specifically a mobile phone or a PDA are considered wireless devices, a desktop PC or a laptop are not
is_tablet						true/false	Tells you if a device is a tablet computer (iPad and similar, regardless of OS)
device_claims_web_support				true/false	Whether the device is wireless or not, the browser may claim web support or not. Opera for Symbian is an example of a browser that claims web support (and tries to render at best) a page that was developed for web presentation independently from the device.
pointing_method	joystick, stylus, touchscreen, clickwheel, "" (empty string) 	Links and widgets can be activated with either a stylus, a finger, a joystick or a BlackBerry-style clickwheel. Devices with this capability set to empty string ("") should have has_pointing_device set to false.
has_qwerty_keyboard					true/false 	Some devices come with a full querty keyboard. This may have a say on how forms or other functions are implemented. Virtual keyboard (a-la Palm pilot) are good enough to make this capability tick to true.
can_skip_aligned_link_row				true/false	Many modern devices (or browser/device combo) let users skip a row of links (for ex: link1|link2|link3|link4) with just one click down. Other devices force users to click multiple times to skip the list of links.
uaprof,uaprof2,uaprof3					String (URL)	UAProf urls can typically be extracted as a HTTP header. This capability may be useful when this is not possible for some reason.
nokia_series						Integer	Nokia Series 20/30/40/60/80 or 90
nokia_edition						Integer	Developer Platform (1/2/3/...)
nokia_feature_pack					0,1,2,3,4,5,6,7,8	Nokia Feature Pack
device_os						String	Information about hosting OS
device_os_version					String	Which version of the hosting OS
mobile_browser						String	Information about the device browser (Openwave, Nokia, Opera, Access, Teleca,...)
mobile_browser_version					String	Which version of the browser
can_assign_phone_number				true/false	Device is a mobile phone and may have a phone number associated to it.


Group:wml_ui (User Interface for WML browser)
Capability Name 					Type 	Description
proportional_font						true/false	The standard font is proportional
built_in_back_button_support				true/false	User may always click on a button to go back
card_title_support					true/false	The device displays the title on the screen
softkey_support						true/false	Softkeys are supported
table_support						true/false	The browser displays tables formatted "correctly" (rather than 1 cell per line)
numbered_menus					true/false	The browser lists numbers to pick an element from a list
menu_with_select_element_
recommended						true/false	A select element is the most usable menu format
menu_with_list_of_links_
recommended						true/false	A list of links is the most usable menu format
icons_on_menu_items_support				true/false	Links may be associated with icons
break_list_of_links_with
_br_element_recommended				true/false	When presenting a list of links the use of <br/> is suggested for better presentation
access_key_support					true/false	respects the "accesskey" attribute of the anchor tag
wrap_mode_support					true/false	The browser can be forced to wrap or not lines
times_square_mode_support				true/false	"time_square_mode_support" is an Openwave browser specific feature related to what happens with code that looks like <p mode="nowrap">. The Openwave browser will present the text in this block on a single line that will only scroll (like marquee) when the line has been activated (has focus). Other browser either cropped such blocks, or force ths user to scroll horizontally on the page.
deck_prefetch_support					true/false	Prefetching of other decks is supported
elective_forms_recommended				true/false	input and select elements can/should be placed in a single card rather than on discrete cards
wizards_recommended					true/false	wizards_recommended
image_as_link_suppor				t	true/false	You may use images to present a link
insert_br_element_
after_widget_recommended				true/false	The use of a break is suggested after widgets
wml_can_display_images_and_
text_on_same_line					true/false	Some devices not display an image and text on the same line. Set this to true if the device supports it
wml_displays_image_in_center				true/false	Some devices will show images aligned in center by default, true if this happens
opwv_wml_extensions_support				true/false	This is specific for Openwave browsers and possibly third party browsers that are compatible. As WML extensions we mean pictograms and other tags that were never formalized by the WAP forum
wml_make_phone_call_string				"none","tel:", "wtai://wp/mc;"	Prefix to initiate a voice call


Group:chtml_ui (User Interface for Compact HTML i;Mode browser)
Capability Name 					Type 	Description
chtml_display_accesskey				true/false	The device displays a number when you use an accesskey
emoji							true/false	Emoji are special characters which appear in i-Mode pages as small icons
chtml_can_display_images_and_
text_on_same_line					true/false	As for WML, this is set to true if the device can display images and text on the same line
chtml_displays_image_in_center				true/false	As for WML, this is set to true if the device will align images in center by default
imode_region						string	This field describes the market region for the device, useful for emoji's and other possible localizations. Possible values as "ja" for Japan, "eu" for Europe, "us" for USA "as" for Asia. "none" means unknown or not set.
chtml_make_phone_call_string				string	Prefix to initiate a voice call
chtml_table_support					true/false	Tables are not supported by default on i-mode/chtml devices. This capability tells you if the device supports this "extra" feature


Group:xhtml_ui (User Interface for XHTML-MP browser)
Capability Name 					Type 	Description
xhtml_honors_bgcolor					true/false	Background colour can be set
xhtml_supports_forms_in_table				true/false	Form entry within a table is possible
xhtml_support_wml2_namespace			true/false	The WML version 2.0 namespace is supported, so the device will successfully render WML2.0 content
xhtml_autoexpand_select				true/false	Some device automatically expand select's (MOT T720, for example)
xhtml_select_as_dropdown				true/false	The device displays select's as dropdown lists
xhtml_select_as_radiobutton				true/false	The device displays select's as radio buttons
xhtml_select_as_popup					true/false	The device displays select's as popup lists, similar to the Openwave GUI extension
xhtml_display_accesskey				true/false	The device displays a number when you use an accesskey
xhtml_supports_invisible_text				true/false	
xhtml_supports_inline_input				true/false	Some browsers let you type text locally. Others bring you to a separate data entry control.
xhtml_supports_monospace_font				true/false	Does device support monospace fonts only?
xhtml_supports_table_for_layout				true/false	This device support for tables is solid enough that you can use tables to layout content on the screen.Used in WALL)
xhtml_supports_css_cell_
table_coloring						true/false	CSS support in this device is good enough that table cells are correctly colored when the color is defined through CSS (Used in WALL)
xhtml_format_as_css_property				true/false	This field is true if the device supports a css property to define the format of an input field. This is what the "format" attribute was in WML. Follows the same rules as "format" used to do. Example:
style=
"-wap-input-format:NNNN" (Used in WALL)
xhtml_format_as_attribute				true/false	This is set true if the device supports the "format" attribute in input fields (Used in WALL)
xhtml_nowrap_mode					true/false	Does device support wrap mode as a XHTML attribute? (Used by WALL)
xhtml_marquee_as_css_property			true/false	Does device support MARQUEE though CSS syntax? (used by WALL)
xhtml_readable_background_color1			string	This and the following properties lets you define 2 colors which interoperate visually on the device. For example, by using one of these two colors as background, you don't risk that an hyperlink disappears against its background. (Used by WALL) against
xhtml_readable_background_color2			string	refer to xhtml_readable_background_
color1 for description (Used by WALL)
xhtml_allows_disabled_
form_elements						true/false	XHTML lets you define "disabled" form elements. If this actually works on the different devices is tracked down by this capability.
xhtml_document_title_support				true/false	While one can define the document title with the title tag, not all devices actually render the title. This capability keeps track of that behavior (Used by WALL)
xhtml_preferred_charset					string	UTF-8 should be supported by default, but some devices have problems. Here you may find alternative charsets such as iso8859. This field does not present the exact charset because with ISO charsets you may need to specify the one of your region (1, 15, other) - Capability mentor: Pau Aliagas
opwv_xhtml_extensions_support				true/false	The Openwave browser has some supports some useful extensions. Tracked by this capability (used by WALL)
xhtml_make_phone_call_string				string	Prefix to initiate a voice call (Used by WALL)
xhtmlmp_preferred_mime_type				string	Most devices should support both text/html and the specific XHTML MP mime type. Some are a little pickie, here you should find a mime type that always works. Default is text/html
xhtml_table_support					true/false	tables SHOULD be supported as syntax, but are often rendered poorly. This tag tells you if the browser is able to render tables decently
xhtml_send_sms_string					none, sms:,smsto:	Indicates whether device supports the href="sms:+num" syntax to trigger the SMS client from a link. Syntax may be "smsto:" on some devices or not be supported at all.
xhtml_send_mms_string					none, mms:,mmsto:	Indicates whether device supports the href="mms:+num" syntax to trigger the MMS client from a link. Syntax may be "mmsto:" on some devices or not be supported at all.
xhtml_file_upload					not_supported, supported, supported _user_intervention	Indicates whether the browser honors the type="file" element in forms (users can uplad files on their devices to a remote server).
On some devices, users may need to copy/move the file from a given directory to a directory visible to the web browser on the device file-system.
xhtml_supports_iframe					none,partial,full	Indicated whether the browser supports iFrame. Partial support means that the content in the containing page is not rendered if placed after the iframe.
cookie_support						true/false	Indicates whether the browser supports cookies (please observe that the cookie may be missing in case an operator strips it out. Similarly, a device with no cookie support may automatically become cookie enabled if a WAP gateway manages cookies on behalf of the device)
accept_third_party_cookie				true/false	Indicates whether the phone accepts a cookie set from a pixel in a page of a different domain (assuming device with default settings)
xhtml_avoid_accesskeys				true/false	Some browsers define standard keyboard accelerators which conflict with the accesskeys defined by the author. It is better to avoid accesskeys for those devices.
xhtml_can_embed_video	none, plain, play_and_stop	Some browsers support embedding of video through the <object> tag. For ex:

<object type="video/3gpp"
  data="rtsp://.../video.3gp"
  id="player" width="176"
  height="150"
  autoplay="true">
</object>

This capability will track whether the XHTML browser supports this.

    * none = Inline video playback/streaming not supported
    * plain = Video will play
    * play_and_stop = Video will play and user will have a chance to stop and resume playback. 



Group:html_ui (User Interface for HTML browser)
Capability Name 					Type 	Description
Note: Capabilities in this group refer to content served with the HTML (text/html) MIME type
html_preferred_dtd					"none", "xhtml_mp1", "xhtml_mp11", "xhtml_mp12", "html4", "xhtml_transitional", "xhtml_basic", "html5"	If HTML is served to the browser, this capability tells which DTD is better to use (on webkit browser it usually does not matter match as long as MIME is text/html)
Token explanation:

none = ''

html4 = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">'

html5 = '<!DOCTYPE HTML>'

xhtml_basic = '<!DOCTYPE html PUBLIC  "-//W3C//DTD XHTML Basic 1.0//EN"
  "http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">'

xhtml_mp1 = '<!DOCTYPE html PUBLIC  "-//WAPFORUM//DTD XHTML Mobile 1.0//EN"
  "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">'

xhtml_mp11 = '<!DOCTYPE html PUBLIC  "-//WAPFORUM//DTD XHTML Mobile 1.1//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd">'

xhtml_mp12 = '<!DOCTYPE html PUBLIC  "-//WAPFORUM//DTD XHTML Mobile 1.2//EN"
  "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">'

xhtml_transitional = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'

viewport_supported					true/false	is the "viewport" META tag supported? supported by Webkit, Opera and quite a few others
viewport_width	"", "device_width_token", "width_equals_resolution_width", "width_equals_max_image_width" 	"" = not applicable

"device_width_token" = use sting 'width=device-width' as value,

"width_equals_resolution_width" = use (display) resolution_width,

" width_equals_max_image_width" = use (display) max_image_width_width
viewport_initial_scale					String	Recommended initial-scale parameter for viewport
viewport_maximum_scale				String	Recommended maximum-scale parameter for viewport
viewport_minimum_scale				String	Recommended minimum-scale parameter for viewport
mobileoptimized						true/false	Whether device honors:

<meta name="MobileOptimized"
       content="width" />

This will prevent the browser from trying to adapt the page to fit the mobile screen. Mainly supported by IE Mobile.
handheldfriendly	true/false	Whether device honors:

<meta name="HandheldFriendly"
       content="true" />

This will prevent the browser from trying to adapt the page to fit the mobile screen. Mainly supported by BlackBerries.
canvas_support	none, no-text, full	Whether browser honors HTML 5 canvases
image_inlining	true/false	Whether the browser supports the possibility to have pictures nested within the HTML itself as Base64 ASCII garbage (DATA URI scheme)
		


Group:css CSS-issues	
Capability Name 					Type 	Description
css_supports_width_as _percentage			true/false	identify those devices for which the CSS property width:100% does not work as expected (many Nokias). In those case, one is better off using the max_image_width to force tables to be the correct size across the screen. This capability refers to both XHTML and HTML content
css_border_image					none, css3, webkit, mozilla, opera 	The powerful border-image feature is supported in some form (refer to http://t.wurfl.com (group CSS) for actual test). Can be used to create fancy buttons
css_rounded_corners					none, css3, webkit, mozilla, opera 	The powerful border-radius feature is supported in some form (refer to http://t.wurfl.com (group CSS) for actual test). Can be used for round corners without corner images
css_gradient						none, css3, webkit, mozilla 	The powerful gradient feature is supported in some form (refer to http://t.wurfl.com (group CSS) for actual test). Can be used to create gradients purely with CSS
css_spriting						true/false	CSS can refer to pictures and use them in different circumstances as backgrounds, including clipping. This is useful on the web to minimize download times for graphical assets (but does not work on all mobile browsers/devices)


Group:ajax Supported Mobile Ajax features
Capability Name 					Type 	Description
ajax_support_javascript					true/false	A device can be said Javascript enabled only if the following features are reliably supported: alert, confirm, access form elements (dynamically set/modify values), setTimeout, setInterval, document.location.
If a device fails one of these tests, mark as false (i.e. crippled javascript is not enough to be marked as javascript-enabled)
ajax_support _getelementbyid				true/false	can select a node through its ID
ajax_xhr_type						none, standard, msxml2, legacy_microsoft	Which syntax to create a XMLHttpRequest() object:none or XMLHttpRequest(); ActiveXObject("Msxml2.XMLHTTP") and ActiveXObject("Microsoft.XMLHTTP")
ajax_support_inner_html					true/false	can stick a bit of HTML into a DIV. In the case of xml documents, this may not be working as expected (notably on the iPhone). So, always make sure you are using the right DTD/Mime-type for the documents, if you intend to use innerHTML().
ajax_manipulate_dom					true/false	Indicated whether parentNode, getElementsByTagName and getElementsByName are supported (all of them).
ajax_manipulate_css					true/false	Modify CSS property programmatically and have the changes all immediately reflected visually in the rendering. In particular, display: none/block (with page reflow) is supported.
ajax_support_events					true/false	onload, onclick, onsubmit and onselect are supported
ajax_support_event _listener				true/false	(Event Listeners) Indicates whether browser allows the registration of event listeners on event targets.
ajax_preferred_geoloc_api				none, gears, w3c_api	Preferred way to do geolocation through JavaScript


Group:markup supported mark languages
Capability Name 					Type 	Description
xhtml_support_level	[-1 |..| 4]	Assuming the device supports some form of XHTML, this capability measures how reliably certain common designer features are supported, according to the following description:

- level "-1": 
no XHTML support of any kind.
Possible WML support
Nokia 7110, 7210 as well as
all UP.Browser 4 and 5 devices.

- level "0" :
basic XHTML Support.
Minimum screen-width: 100 pixel
No (or very unreliable) CSS support.
Poor table support or none at all.
Basic forms: text field, select-option, 
submit button.
May not be able to support input 
mask on fields.
Ex Device: SonyEricsson T610/T616

- level "1" : 
XHTML with some CSS support.
Minimum sceen-width: 120 pixels.
Hyperlinks may not be collorable by CSS.
Basic table support: 2x2 or more.
Colspan and rowspan may not be supported.
"width" expressed as percentage may be 
unreliable.
Ex Device: Sharp GX 10, Nokia 3650

- level "2" : 
Assume same capabilities as 
level "1", but may vary in the future.
Ex Device: Nokia6600,Nokia5300

- level "3" : 
Excellent CSS support.
Padding, border and margin are correctly 
applied.
Can reliable apply colors to links, 
text and background.
CSS graphic effects are pixel perfect
Minimum sceen-width: 164 pixels.
Can support complex tables (but not 
necessarily nested tables) up to 
4 cells in a row.
Setting "font-size" of 10px or above produces readable text.          
Supports background images also 
when applied through CSS.
Generally running on 3G devices.
Ex: Nokia Series 60 DP 3,
Browsers: Openwave Mobile Browser 6.2, 
MS Mobile Explorer, 
recent BlackBerrys. Netfront 3.2,  Sony PSP...
(assuming high-bandwidth, Edge/UMTS/...)
             
- level "4" :
Level 3 + Ajax support.
Toggle display property. 
XMLHTTPRequest().
Ex: Safari Browser (including iPhone), MS Mobile Explorer, Openwave 7.2.

preferred_markup					string	This field identifies which markup is best supported by the device. This field is filled on personal experiences of our contributors and is used by the WALL library. Values for this capability look like: wml_1_1, html_wi_imode_compact_
generic and html_wi_oma_xhtmlmp_1_0. Just like any other capability, you may override this value in the patch file.
Important note: the "html_web_4_0" value for this capability suggests that the device is better served with HTML content (and MIME type). In this case, referring to capabilities in the "html_ui" and "css" groups may be useful.
wml_1_1						true/false	Supports WML version 1.1
wml_1_2						true/false	Supports WML version 1.2
wml_1_3						true/false	Supports WML version 1.3
html_wi_w3_xhtmlbasic					true/false	XHTML basic is XHTML reduced to a minimal set of tags, and was introduced to serve as a basis for a markup which would work on devices with very limited capabilities.
html_wi_oma_xhtmlmp_1_0				true/false	XHTML MP is XHTML Basic with the addition of a few extra tags to allow for the application of WCSS ('style' attribute and tag, 'hr' tag)
html_wi_imode_html_1					true/false	Supports DoCoMo's iHTML version 1.0
html_wi_imode_html_2					true/false	Supports DoCoMo's iHTML version 2.0
html_wi_imode_html_3					true/false	Supports DoCoMo's iHTML version 3.0
html_wi_imode_html_4					true/false	Supports DoCoMo's iHTML version 4.0
html_wi_imode_html_5					true/false	Supports DoCoMo's iHTML version 5.0
html_wi_imode_htmlx_1					true/false	Supports DoCoMo's xHTML version 1.0
html_wi_imode_ compact_generic			true/false	Supports generic compact HTML (cHTML)
html_web_3_2						true/false	Supports HTML version 3.2
html_web_4_0						true/false	Supports HTML version 4
voicexml						true/false	Supports voice XML
multipart_support					true/false	Correctly supports multipart/mixed content to package full pages (HTML, CSS and pictures) into one single object.


Group: cache
Capability Name 					Type 	Description
total_cache_disable_support				true/false	possibility to disable the browser's cache completely
time_to_live_support					true/false	Device support 'time to live'(TLL) or not. The length of time that a device keeps a deck in cache is called the time to live (TTL). The default TTL is 30 days (or until memory is exhausted) for Openwave browsers. If a deck contains time-sensitive information, you can specify a shorter TTL so that the device will reload the deck from the server more frequently.


Group:display
Capability Name 					Type 	Description
resolution_width						any integer number	This field represents the screen width expressed in pixels
resolution_height					any integer number	This field represents the screen height expressed in pixels
columns						any integer number	Number of columns presented
rows							any integer number	Number of lines presented
max_image_width					any integer number	Width of the images viewable (usable) width expressed in pixels
max_image_height					any integer number	Height of the images viewable (usable) width expressed in pixels
physical_screen_width					any integer number	Screen width in millimiters
physical_screen_height					any integer number	Screen height in millimiters
dual_orientation						true/false 	Some devices may be flipped, i.e. user may change orientation, effectively inverting screen_width and screen_height for mobile web browsing and, possibly, for other functions.


Group:image_format
Capability Name 					Type 	Description
wbmp							true/false	supports wbmp format
bmp							true/false	Supports bmp format
epoc_bmp						true/false	Supports the EPOC (Symbian) bitmap format, also known as mbm
gif							true/false	supports gif format
gif_animated						true/false	supports animated gif (gif89a) format
jpg							true/false	supports jpg format
png							true/false	supports png format
tiff							true/false	supports tif format
transparent_png_alpha					true/false	
transparent_png_index					true/false	
svgt_1_1						true/false	supports SVGT v1.1 - Capability mentor: Antoine Quint
svgt_1_1_plus						true/false	supports SVGT v1.1+ - Capability mentor: Antoine Quint
greyscale						true/false	supports greyscale format
colors							any integer number	In general the number of colors used by the phone


Group:bugs
Capability Name 					Type 	Description
post_method_support					true/false	If true the phone supports HTTP POST method
basic_authentication_support				true/false	basic authentication support (login and password)
emptyok						true/false	An empty select is allowed
empty_option_value_support				true/false	If true the phone will allow the user to pick an empty value from a select


Group:wta
Capability Name 					Type 	Description
nokia_voice_call						true/false	Supports the Nokia 'make call' function
wta_voice_call						true/false	Supports the standard WML call function
wta_phonebook						true/false	The WTA implementation supports access to the device's phonebook
wta_misc						true/false	The WTA implementation supports the miscellaneous features of the WTAI specification
wta_pdc						true/false	Supports WTA over a PDC network


Group:security
Capability Name 					Type 	Description
https_support						supported, not_supported, not_predictable	generic support for HTTPS protocol (SSL connections). Deafult for generic is "supported", because it is generally recommended to ask users to activate an HTTPS connection.
https_verisign_class3					true/false	Verisign Class 3 Certificate for SSL supported
phone_id_provided					true/false	The IMEI number is accessible


Group:bearer
Capability Name 					Type 	Description
has_cellular_radio					true/false	Device has cellular technology (most probably a phone, but not necessarily. May be a data-only device such as Kindle or Nokia N800)
max_data_rate						value in Kilobits. one kilobit = 1000 bit	Maximum bandwidth reachable by the device. Possible values:
HSDPA = 1800 | 3600 | 7200 | 14400 depending on the device
UMTS(3G) = 384
EGPRS/EDGE = 200
GPRS = 40
HSCSD = 29
CSD = 9
wifi							true/false	Device can access WiFi connections
sdio							true/false	Device can accept SDIO cards (for WiFi)
vpn							true/false	Device can support VPN connections


Group:storage
Capability Name 					Type 	Description
max_deck_size						any integer number	Maximum allowed size for the mark-up in a page (refers to XHTML browser. Apllies to WML for WML-only browsers)
max_url_length_in_requests				any integer number	Maximum allowed URL length
max_url_length_homepage				any integer number	Maximum allowed URL length for the browser's homepage
max_url_length_bookmark				any integer number	Maximum allowed URL length for a bookmark
max_url_length_cached_page				any integer number	Maximum allowed URL length for a cached page
max_no_of_connection_settings				any integer number	Number of connection profiles supported
max_no_of_bookmarks					any integer number	Number of bookmarks the browser can store
max_length_of_username				any integer number	Maximum allowed length for a username
max_length_of_password				any integer number	Maximum allowed length for a password
max_object_size					any integer number	The maximum file size (in bytes) supported when downloading using WTP-SAR


Group:object_download
Capability Name 					Type 	Description
downloadfun_support					true/false	if true the phone supports downloadfun features
directdownload_support					true/false	if true the phone supports object downloading in an anchor
inline_support						true/false	if true the phone has the possibility to save an image or object shown in a page
oma_support						true/false	if true the phone supports OMA specifications for object downloading
ringtone							true/false	if true the phone supports the download of ringtones
ringtone_midi_monophonic				true/false	support for monophonic (type 0) midi files
ringtone_midi_polyphonic				true/false	support for polyphonic midi files
ringtone_imelody					true/false	support for the download of iMelody files
ringtone_digiplug					true/false	support for the download of digiplug files
ringtone_compactmidi					true/false	support for the download of compact-midi files
ringtone_mmf						true/false	support for the download of MMF/SMAF files (Yamaha)
ringtone_rmf						true/false	support for the download of RMF files (Beatnik)
ringtone_xmf						true/false	support for the download of XMF files (Beatink - midi approved)
ringtone_amr						true/false	support for the download of AMR files
ringtone_awb						true/false	support for the download of AMR wide band files
ringtone_aac						true/false	support for the download of AAC files
ringtone_wav						true/false	support for the download of WAV files
ringtone_mp3						true/false	support for the download of MP3 files
ringtone_spmidi						true/false	support for the download of SPmidi files
ringtone_voices						any integer number	Represents the maximum number of voices for a downloaded ringtone
ringtone_df_size_limit					any integer number	Size limit in bytes of downloadable ringtones through downloadfun
ringtone_directdownload_size_limit			any integer number	Size limit in bytes of downloadable ringtones through direct download
ringtone_inline_size_limit				any integer number	Size limit in bytes of downloadable ringtones for inline objects
ringtone_oma_size_limit					any integer number	Size limit in bytes of downloadable ringtones through OMA DD
wallpaper						true/false	if true the phone supports the download of wallpapers
wallpaper_wbmp						true/false	support for wbmp images
wallpaper_bmp						true/false	support for bmp images
wallpaper_gif						true/false	support for gif images
wallpaper_jpg						true/false	support for jpg images
wallpaper_png						true/false	support for png images
wallpaper_greyscale					true/false	true if the phone users a greyscale
wallpaper_colors					any integer number	This is the number in bit of displayable colors.
Note: if a phone uses 8 tones of grey, you should set wallpaper_greyscale to true and wallpaper_colors to 3
wallpaper_max_width					any integer number	Maximum width supported for a wallpaper
wallpaper_max_height					any integer number	Maximum height supported for a wallpaper
wallpaper_preferred_width				any integer number	Maximum width suggested for a wallpaper
wallpaper_preferred_height				any integer number	Maximum height suggested for a wallpaper
wallpaper_df_size_limit					any integer number	Maximum size in bytes of a wallpaper
wallpaper_directdownload_size_limit			any integer number	Maximum size in bytes of a wallpaper
wallpaper_inline_size_limit				any integer number	Maximum size in bytes of a wallpaper
wallpaper_oma_size_limit				any integer number	Maximum size in bytes of a wallpaper
wallpaper_resize					string	Describes if and how the device resizes a downloaded wallpaper if not exactly the same size of the screen. Possible values are "none", "fixed_ratio" (rescale respecting original proportions), "crop_centered", "crop_top_left".
screensaver						true/false	if true the phone supports the download of screensavers
screensaver_wbmp					true/false	support for wbmp images
screensaver_bmp					true/false	support for bmp images
screensaver_gif						true/false	support for gif images
screensaver_jpg						true/false	support for jpg images
screensaver_png					true/false	support for png images
screensaver_greyscale					true/false	true if the phone users a greyscale
screensaver_colors					any integer number	This is the number in bit of displayable colors.
Note: if a phone uses 8 tones of grey, you should set wallpaper_greyscale to true and wallpaper_colors to 3
screensaver_max_width					any integer number	Maximum width supported for a screensaver
screensaver_max_height					any integer number	Maximum height supported for a screensaver
screensaver_preferred_width				any integer number	Maximum width suggested for a screensaver
screensaver_preferred_height				any integer number	Maximum height suggested for a screensaver
screensaver_df_size_limit				any integer number	Maximum size in bytes of a screensaver through downloadfun
screensaver_directdownload_size_limit			any integer number	Maximum size in bytes of a screensave through direct download
screensaver_inline_size_limit				any integer number	Maximum size in bytes of a screensaver for an inline object
screensaver_oma_size_limit				any integer number	Maximum size in bytes of a screensaver through OMA DD
screensaver_resize					string	Describes if and how the device resizes a downloaded screensaver if not exactly the same size of the screen. Possible values are "none", "fixed_ratio" (rescale respecting original proportions), "crop_centered", "crop_top_left".
picture							true/false		if true the phone supports the download of picture files
picture_wbmp						true/false	support for wbmp images
picture_bmp						true/false	support for bmp images
picture_gif						true/false	support for gif images
picture_jpg						true/false	support for jpg images
picture_png						true/false	support for png images
picture_greyscale					true/false	true if the phone users a greyscale
picture_colors						any integer number	This is the number in bit of displayable colors.
Note: if a phone uses 8 tones of grey, you should set wallpaper_greyscale to true and wallpaper_colors to 3
picture_max_width					any integer number	Maximum width supported for a picture
picture_max_height					any integer number	Maximum height supported for a picture
picture_preferred_width					any integer number	Maximum width suggested for a picture
picture_preferred_height					any integer number	Maximum height suggested for a picture
picture_df_size_limit					any integer number	Maximum size in bytes of a picture throught downloadfun
picture_directdownload_size_limit			any integer number	Maximum size in bytes of a picture throught direct download
picture_inline_size_limit					any integer number	Maximum size in bytes of a picture for an inline object
picture_oma_size_limit					any integer number	Maximum size in bytes of a picture through OMA DD
picture_resize						string	Describes if and how the device resizes a downloaded picture if not exactly the same size of the screen. Possible values are "none", "fixed_ratio" (rescale respecting original proportions), "crop_centered", "crop_top_left".
video							true/false	true if the phone may download video clips


Group:playback
Capability Name 					Type 	Description
progressive_download					true/false	if true the phone supports playback of audio/video content which is still being downloaded
hinted_progressive_download				true/false	Progressive download works, but contentent needs to be "hinted". This may seem funny, but this practice was made necessary by Android
playback_vcodec_h263_0				-1, 10, 20, 30, 40, 45, 50, 60, 70	(-1 = no h263 type 0 for downloaded video content) support level for devices that support H.263 type 0 encoded videos. Please refer to Table 2 - H.263 Levels to infer the value of other capabilities.
playback_vcodec_h263_3				-1, 10, 20, 30, 40, 45, 50, 60, 70	(-1 = no h263 type 3 for downloaded video content) support level for devices that support H.263 type 3 encoded videos. Please refer to Table 2 - H.263 Levels to infer the value of other capabilities.
playback_vcodec_mpeg4_sp				-1, 0, 0b, 1, 2, 3	(-1 = no MPEG4 Simple Profile downloaded videos) support level for devices that support MPEG 4 encoded videos. Please refer to Table 3 - MPEG-4 Simple Profile Levels to infer the value of other capabilities.
playback_vcodec_mpeg4_asp				-1, 0, 1, 2, 3, 3b, 4	(-1 = no MPEG4 Advanced Simple Profile videos) support level for devices that support MPEG 4 encoded videos. Please refer to Table 4 - MPEG-4 Advanced Simple Profile Levels to infer the value of other capabilities.
playback_vcodec_h264_bp				-1, 1, 1b, 1.1, 1.2, 1.3, 2	(-1 = no H264 Baseline Profile videos) support level for devices that support "H264 Base Profile"-encoded videos. Please refer to Table 1 - H.264 Levels to infer the value of other capabilities.
playback_real_media					"none", 8,9,10	Device supports playback of RealMedia format (none = REAL NOT SUPPORTED), and, if supported, which version (V8, V9 or V10)
playback_3gpp						true/false	true if the phone supports 3GPP videos (including H.263)
playback_3g2						true/false	true if the phone supports 3GPP 2 videos (for CDMA devices)
playback_flv						true/false	true if the phone supports Adobe's Flash Video
playback_mp4						true/false	true if the phone supports MP4 videos
playback_wmv						"none",7,8,9	none=WMV not supported. 7|8|9= WMV codec
playback_mov						true/false	true if the phone supports MOV videos
playback_acodec_amr					none,nb,wb,wb+	(none=no AMR codec supported). AMR version
playback_acodec_aac					none, lc, ltp, heaac, heaac2	(none=no AAC codec supported). AAC version
playback_acodec_qcelp					true/false	True if the device can play videos with Qualcomm Code Excited Linear Predictive waveform audio format
playback_df_size_limit					integer	Max size in bytes for downloadfun. 0 is the default
playback_directdownload_size_limit			integer	Max size in bytes for directdownload. 0 is the default
playback_inline_size_limit				integer	Max size in bytes for inline download. 0 is the default
playback_oma_size_limit				integer	Max size in bytes for OMA DD. 0 is the default


Group:drm
Capability Name 				Type 	Description
oma_v_1_0_forwardlock				true/false	true if the phone support OMA DRM ForwardLock V1.0
oma_v_1_0_combined_delivery			true/false	true if the phone support OMA DRM Combined Delivery V1.0
oma_v_1_0_separate_delivery			true/false	true if the phone support OMA DRM Separate Delivery V1.0


Group:streaming
Capability Name 				Type 	Description
streaming_video					true/false	true if the phone supports video streaming
streaming_real_media				"none",8,9,10	Device supports streaming in RealMedia format (none = REAL NOT SUPPORTED), and, if supported, which version (V8, V9 or V10)
streaming_3gpp					true/false	true if the phone supports 3GPP
streaming_mp4					true/false	true if the phone supports MP4
streaming_wmv					"none",7,8,9	none=WMV not supported. 7|8|9= WMV codec
streaming_mov					true/false	true if the phone supports MOV
streaming_flv					true/false	true if the phone supports FLV (Flash Video)
streaming_3g2					true/false	true if the phone supports 3GPP 2
streaming_video_size_limit			integer	Max size in bytes for the clip
streaming_vcodec_h263_0			-1, 10, 20, 30, 40, 45, 50, 60, 70	(-1 = no h263 type 0 streaming) support level for devices that support H.263 type 0 encoded videos. Please refer to Table 2 - H.263 Levels to infer the value of other capabilities.
streaming_vcodec_h263_3			-1, 10, 20, 30, 40, 45, 50, 60, 70	(-1 = no h263 type 0 streaming) support level for devices that support H.263 type 3 encoded videos. Please refer to Table 2 - H.263 Levels to infer the value of other capabilities.
streaming_vcodec_mpeg4_sp			-1, 0, 0b, 1, 2, 3	(-1 = no MPEG4 Simple Profile streaming) support level for devices that support MPEG 4 encoded videos. Please refer to Table 3 - MPEG-4 Simple Profile Levels to infer the value of other capabilities.
streaming_vcodec_mpeg4_asp			-1, 0, 1, 2, 3, 3b, 4	(-1 = no MPEG4 Advanced Simple Profile streaming) support level for devices that support MPEG 4 encoded videos. Please refer to Table 4 - MPEG-4 Advanced Simple Profile Levels to infer the value of other capabilities.
streaming_vcodec_h264_bp			-1, 1, 1b, 1.1, 1.2, 1.3, 2	(-1 = no H264 Baseline Profile streaming) support level for devices that support H264 encoded videos. Please refer to Table 1 - H.264 Levels to infer the value of other capabilities.
streaming_acodec_amr				none,nb,wb,wb+	(none=no AMR codec supported). AMR version
streaming_acodec_aac				none, lc, ltp, heaac, heaac2	(none=no AAC codec supported). AAC version
streaming_preferred_protocol			rtsp,http,mms	Not all devices support RTSP for streaming (iPhone doesn't)


Group:wap_push
Capability Name 				Type 	Description
wap_push_support				true/false	true if the phone support WAP Push messages
connectionless_service_indication		true/false	true if the phone supports it
connectionless_service_load			true/false	true if the phone supports it
connectionless_cache_operation			true/false	true if the phone supports it
connectionoriented_unconfirmed_
service_indication				true/false	Whether unconfirmed service indications are supported, when connection-oriented push is used
connectionoriented_unconfirmed_
service_load					true/false	Whether unconfirmed service load operations are supported, when connection-oriented push is used
connectionoriented_unconfirmed_
cache_operation					true/false	Whether unconfirmed cache operations are supported, when connection-oriented push is used
connectionoriented_confirmed_
service_indication				true/false	Whether confirmed service indications are supported, when connection-oriented push is used
connectionoriented_confirmed_
service_load					true/false	Whether confirmed service load operations are supported, when connection-oriented push is used
connectionoriented_confirmed_
cache_operation					true/false	Whether confirmed cache operations are supported, when connection-oriented push is used
utf8_support					true/false	Whether the UTF-8 character set is supported
ascii_support					true/false	Whether the ASCII character set is supported
iso8859_support					true/false	Whether the ISO-8559 character set is supported
expiration_date					true/false	Whether an expiry date can be set for the resource


Group:mms
Capability Name 				Type 	Description
receiver						true/false	May receive MMS messages	
sender						true/false	May send MMS messages
mms_max_height				any integer number	Maximum height for an image
mms_max_width				any integer number	Maximum width for an image
built_in_recorder					true/false	The device features a built-in audio recorder
built_in_camera					true/false	The device features a built-in camera
mms_jpeg_baseline				true/false	Baseline JPG images support
mms_jpeg_progressive				true/false	Progressive JPG images support
mms_gif_static					true/false	Static GIF (87a) support
mms_gif_animated				true/false	Animated GIF (89a) support
mms_png					true/false	PNG support
mms_bmp					true/false	BMP support	
mms_wbmp					true/false	WBMP support
mms_amr					true/false	AMR support
mms_wav					true/false	WAV support
mms_midi_monophonic				true/false	Monophonic MIDI support
mms_midi_polyphonic				true/false	Polyphonic MIDI support
mms_midi_polyphonic_voices			integer	If polyphonic MIDI is supported, the number of available voices
mms_spmidi					true/false	SPMIDI support
mms_ota_bitmap				true/false	OTA Bitmap support
mms_nokia_wallpaper				true/false	Nokia wallpaper support
mms_nokia_operatorlogo			true/false	Nokia operator logo support
mms_nokia_3dscreensaver			true/false	Nokia 3D screensaver support
mms_nokia_ringingtone				true/false	Nokia ringingtone support
mms_rmf					true/false	RMF support
mms_symbian_install				true/false	Symbian install files support (May receive Symbian install files inside an MMS)
mms_jar					true/false	JAR support
mms_jad					true/false	JAD support
mms_vcard					true/false	Vcard support
mms_wml					true/false	The message may contain wml
mms_wbxml					true/false	The message may contain wbxml
mms_wmlc					true/false	The message may contain wmlc
mms_video					true/false	The message may contain a video clip
mms_mp4					true/false	The message may contain an MP4 video
mms_3gpp					true/false	The message may contain a 3GPP video
mms_3gpp2					true/false	The message may contain a 3GPP2 (CDMA phones) video
mms_max_frame_rate				integer	The max frame rate for the video


Group:sms Binary SMS and SCKL capabilities.
Capability Name 				Type 	Description
sms_enabled					true/false	true if the phone supports SMS
nokiaring					true/false	true if the phone supports nokiarings
picturemessage					true/false	true if the phone supports Nokia picture messages
operatorlogo					true/false	true if the phone supports Nokia operator logo's (72x14 pixel)
largeoperatorlogo				true/false	true if the phone supports Nokia large operator logo's (72x28 pixel)
callericon					true/false	true if the phone supports Nokia caller icons
nokiavcard					true/false	true if the phone supports Nokia vcards
nokiavcal					true/false	true if the phone supports Nokia vcals
sckl_ringtone					true/false	true if the phone supports SCKL ringtones
sckl_operatorlogo				true/false	true if the phone supports SCKL operator logos
sckl_groupgraphic				true/false	true if the phone supports SCKL group graphics
sckl_vcard					true/false	true if the phone supports SCKL vcards
sckl_vcal					true/false	true if the phone supports SCKL vcals
text_imelody					true/false	true if the phone supports textual iMelody
ems						true/false	true if the phone supports EMS messages
ems_variablesizedpictures			true/false	true if the phone supports EMS messages
ems_imelody					true/false	true if the phone supports iMelody over EMS messages
ems_odi					true/false	true if the phone supports EMS ODI (Object Distribution Indicator)
ems_upi					true/false	true if the phone supports EMS UPI (User Prompt Indicator)
ems_version					integer	EMS version
siemens_ota					true/false	true if the phone supports Siemens OTA
siemens_logo_width				integer	Logo width (default is 101)
siemens_logo_height				integer	Logo height (default is 29)
siemens_screensaver_width			integer	Screensaver width (default is 101)
siemens_screensaver_height			integer	Screensaver height (default is 50)
gprtf						true/false	true if the phone supports Motorola proprietary ringtones (GPRTF)
sagem_v1					true/false	true if the phone supports Sagem proprietary ringtones spec 1.0
sagem_v2					true/false	true if the phone supports Sagem proprietary ringtones spec 2.0
panasonic					true/false	true if the phone supports Panasonic proprietary ringtones


Group:j2me
NOTE: this group has been totally reviewed, old tags don't exist any more, check out the new tags
Group mentors: José Manuel Cantera Fonseca and Cristian Rodriguez from Telefonica I+D
Capability Name 				Type 	Description
j2me_midp_1_0					true/false	true if the phone is compliant to MIDP 1.0 specifications
j2me_cldc_1_0					true/false	true if the phone is compliant to CLDC 1.0 specifications
j2me_midp_2_0					true/false	true if the phone is compliant to MIDP 2.0
j2me_cldc_1_1					true/false	true if the phone is compliant to CLDC 2.0 specifications
doja_1_0					true/false	true if the phone is compliant to DoJa 1.0 specifications
doja_1_5					true/false	true if the phone is compliant to DoJa 1.5 specifications
doja_2_0					true/false	true if the phone is compliant to DoJa 2.0 specifications
doja_2_1					true/false	true if the phone is compliant to DoJa 2.1 specifications
doja_2_2					true/false	true if the phone is compliant to DoJa 2.2 specifications
doja_3_0					true/false	true if the phone is compliant to DoJa 3.0 specifications
doja_3_5					true/false	true if the phone is compliant to DoJa 3.5 specifications
doja_4_0					true/false	true if the phone is compliant to DoJa 4.0 specifications
j2me_jtwi					true/false	JTWI support
j2me_mmapi_1_0				true/false	MMAPI 1.0 support
j2me_mmapi_1_1				true/false	MMAPI 1.1 support
j2me_wmapi_1_0				true/false	WMAPI 1.0 support
j2me_wmapi_1_1				true/false	WMAPI 1.1 support
j2me_wmapi_2_0				true/false	WMAPI 2.0 support
j2me_btapi					true/false	BlueTooth API support
j2me_3dapi					true/false	3D API support
j2me_locapi					true/false	Location API support
j2me_nokia_ui					true/false	Nokia UI support
j2me_motorola_lwt				true/false	Motorola LWT support
j2me_siemens_color_game			true/false	Siemens Color Game extension support
j2me_siemens_extension			true/false	Siemens extension support
j2me_heap_size					any integer number	Memory limit in bytes of the memory during runtime
j2me_storage_size				any integer number	The physical memory limit
j2me_max_jar_size				any integer number	Limit in bytes of a midlet downloaded over-the-air
j2me_max_record_store_size			any integer number	Limit in bytes of a record store
j2me_screen_width				any integer number	Screen width in pixels
j2me_screen_height				any integer number	Screen height in pixels
j2me_canvas_width				any integer number	Canvas width in pixels
j2me_canvas_height				any integer number	Canvas height in pixels
j2me_bits_per_pixel				any integer number	Bits per pixels - tells you the colors supported
j2me_audio_capture_enabled			true/false	The device may capture audio clips while in a midlet
j2me_video_capture_enabled			true/false	The device may capture video clips while in a midlet
j2me_photo_capture_enabled			true/false	The device may capture images clips while in a midlet
j2me_capture_image_formats			string	If j2me_photo_capture_enabled is true, this will tell you the image format supported
j2me_http					true/false	The device may start HTTP sessions
j2me_https					true/false	The device may start HTTPS sessions
j2me_socket					true/false	The device may open a socket
j2me_udp					true/false	The device may start UDP sessions
j2me_serial					true/false	The device may start serial connections
j2me_gif					true/false	true if it supports gif images
j2me_gif89a					true/false	true if it supports gif 89a (animated) images
j2me_jpg					true/false	true if it supports jpg images
j2me_png					true/false	true if it supports png images
j2me_bmp					true/false	true if it supports bmp images
j2me_bmp3					true/false	true if it supports bmp3 images
j2me_wbmp					true/false	true if it supports wbmp images
j2me_midi					true/false	true if it supports midi files
j2me_wav					true/false	true if it supports wav files
j2me_amr					true/false	true if it supports amr files
j2me_mp3					true/false	true if it supports mp3 files
j2me_mp4					true/false	true if it supports mp4 audiofiles
j2me_imelody					true/false	true if it supports imelody files
j2me_rmf					true/false	true if it supports rmf files
j2me_au					true/false	true if it supports au files
j2me_aac					true/false	true if it supports aac files
j2me_realaudio					true/false	true if it supports realaudio files
j2me_xmf					true/false	true if it supports xmf files
j2me_wma					true/false	true if it supports wma files
j2me_3gpp					true/false	true if it supports 3gpp files
j2me_h263					true/false	true if it supports h263 files
j2me_svgt					true/false	true if it supports svgt files
j2me_mpeg4					true/false	true if it supports mpeg4 audio/video files
j2me_realvideo					true/false	true if it supports realvideo files
j2me_real8					true/false	true if it supports real8 files
j2me_realmedia					true/false	true if it supports realmedia files
j2me_left_softkey_code				any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the left softkey is pressed, this will be the value returned by the even handler (often a negative number).
j2me_right_softkey_code			any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the right softkey is pressed, this will be the value returned by the even handler (often a negative number).
j2me_middle_softkey_code			any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the middle softkey is pressed, this will be the value returned by the even handler (often a negative number).
j2me_select_key_code				any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the 'select' softkey is pressed, this will be the value returned by the even handler (often a negative number).
j2me_return_key_code				any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the 'return' softkey is pressed, this will be the value returned by the even handler (often a negative number).
j2me_clear_key_code				any integer number	The number refers to the value which is returned by an event handler method in the j2me APIs, so its an internal number (which is implementation dependant). When the 'clear' key is pressed, this will be the value returned by the even handler (often a negative number).
j2me_datefield_no_accepts_null_date		true/false	datefields do not accept empty values (this is a bug)
j2me_datefield_broken				true/false	datefields do not work (this is a bug)


Group:sound_format (supported sound formats)
Capability Name 				Type 	Description
wav						true/false	Supports the .wav (Waveform) sound format
mmf						true/false	Supports the MMF (a Yamaha format) version is understood by the number of voices
smf						true/false	Supports the smf (Standard MIDI File) sound format
mld						true/false	An iMode sound format
midi_monophonic				true/false	Supports the midi (Musical Instrument Digital Interface) monophonic sound format
midi_polyphonic					true/false	Supports the midi (Musical Instrument Digital Interface) polyphonic sound format
sp_midi						true/false	Supports the Scalable Polyphony MIDI sound format
rmf						true/false	Supports the rmf sound format (Beatnik format)
xmf						true/false	Supports the XMF sound format (Beatnik format)
compactmidi					true/false	Supports the Compact MIDI sound format (a Faith Inc. format)
digiplug						true/false	A compact polyphonic sound format developed by the Digiplug company
nokia_ringtone					true/false	Supports the Nokia ringing tone sound format
imelody						true/false	A standard file format for melodies, also adopted as the ringtone format by the 4 companies developing the EMS standard
au						true/false	Also called the uLaw, NeXT, or Sun Audio format
amr						true/false	AMR standard sound format
awb						true/false	AMR wide band standard sound format
aac						true/false	AAC standard sound format
mp3						true/false	Supports the mp3 sound format
qcelp						true/false	Supports the Qualcomm Code Excited Linear Predictive waveform format
evrc						true/false	Supports the Enhanced Variable Rate Codec waveform format
voices						any integer number	Maximum number of notes the device can play at the same time


Group:flash_lite Macromedia/Adobe Flash Lite
Capability Name 				Type 	Description
flash_lite_version				1_1, 1_2, 2_0, 2_1,....	Which version of Flash Lite is supported by device
fl_wallpaper					true/false	Wallpaper Application
fl_screensaver					true/false	Screensaver Application
fl_standalone					true/false	Standalone Flasg lite
fl_browser					true/false	Can run SWF files embedded in HTML
fl_sub_lcd					true/false	SubLCD refers to the external or 2nd display of a device. The ability for this second LCD to display SWF files.


Group:transcoding Handle abusive transcoders
Capability Name 				Type 	Description
is_transcoder					true/false	Transcoders hide real device information. This capability will be true if a transcoder is detected and may be used to treat this request specially
transcoder_ua_header				String	Transcoders may be placing the original device UA string in a different header. This capability contains the name of the header where the original device UA string *may* be found.


Group:rss Native support for RSS feeds
Capability Name 				Type 	Description
rss_support					true/false	Device has native support for RSS feeds


Group:pdf Native support for PDF documents
Capability Name 				Type 	Description
pdf_support					true/false	Can read PDF files natively.


