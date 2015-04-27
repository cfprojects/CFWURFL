<cfoutput>
Creating the WURFL file and the patch file<br />
<cfflush />

<cfset wurflLocation = GetDirectoryFromPath(ExpandPath("*.*")) & "wurfl/wurfl-latest.zip" />
<cfset patchLocation = GetDirectoryFromPath(ExpandPath("*.*")) & "wurfl/patches" />

<cfset wurfl = createObject("component","cfwurfl").init(wurflLocation,patchLocation) />

Now I have an instance, throw some user strings at it<br />
<cfflush />

<cfset stringStructure = {iPhone = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3",
	iPad = "Mozilla/5.0(iPad; U; CPU iPhone OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B314 Safari/531.21.10",
	Blackberry = "BlackBerry9700/5.0.0.351 Profile/MIDP-2.1 Configuration/CLDC-1.1 VendorID/123",
	Android = "Mozilla/5.0 (Linux; U; Android 2.1; en-us; Nexus One Build/ERD62) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17",
	HTC = "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 8.12; MSIEMobile 6.0) USCCHTC6875",
	Firefox = "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3",
	IE = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1)",
	NexusOne = "Mozilla/5.0 (Linux; U; Android 2.1; en-us; Nexus One Build/ERD62) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Mobile Safari/530.17"
} />

<cfloop collection="#stringStructure#" item="thisDevice">
	<cfset thisString = structFind(stringStructure,thisDevice) />
	#thisDevice#: #thisString#<br />
	Markup: #wurfl.getMarkup(thisString)#<br />
	Wireless: #wurfl.getCapability(thisString,"is_wireless_device")#<br />
	Preferred Markup: #wurfl.getCapability(thisString,"preferred_markup")#<br />
	Display: #wurfl.getCapability(thisString,"resolution_width")# x #wurfl.getCapability(thisString,"resolution_height")#<br />
<br />
</cfloop>

</cfoutput>