<cfcomponent displayname="CF WURFL" output="false">
	<!---
	<fusedoc fuse="cfwurfl.cfc" language="ColdFusion" specification="2.0">
		<responsibilities>
			Given a path to a WURFL file and a path to the patches directory, I instantiate a WURFL responder.
			Once the responder is instantiated, send me a userAgent string and then ask for the capabilities, 
			and I'll respond. A list of the capabilities that can be returned are available at 
			http://wurfl.sourceforge.net/help_doc.php
		</responsibilities>
		
		<properties>
			<history author="Rob Kolosky" date="6/11/2010" role="FuseCoder" type="Create" />
			<history author="Rob Kolosky" date="7/6/2010" comment="If the patches directory has any non-XML files in it, the WURFL holder fails to load. Added a FileFilter" />
		</properties>
	</fusedoc>
	--->
	
	<cffunction name="init" displayname="Initilization" hint="I prepare the component for use" access="public" output="false" returntype="any">
		<cfargument name="wurflFile" displayName="WURFL File" type="String" hint="The path to the WURFL file" required="true" />
		<cfargument name="patches" displayName="Patches" type="String" hint="Path to the WURFL patches directory" required="true" />
		
		<cfset var wurflObj = "" />
		<cfset var patchObj = "" />
		<cfset var patchArray = "" />
		
		
		<cfif Len(arguments.wurflFile) gt 0>
			<cfif fileExists(arguments.wurflFile)>
				<cfset setWurfl(arguments.wurflFile) />
			<cfelse>
				<cfthrow message="You must provide an absolute path to the WURFL file." />
			</cfif>
		<cfelse>
			<cfthrow message="You cannot provide an empty string to the WURFL file." />
		</cfif>
		
		<cfif Len(arguments.patches) gt 0>
			<cfif directoryExists(arguments.patches)>
				<cfset setPatches(arguments.patches) />
			<cfelse>
				<cfthrow message="You must provide an absolute path the the directory where the patch files are stored." />
			</cfif>
		</cfif>
		
		<cfset wurflObj = createObject("java","java.io.File").init(arguments.wurflFile) />
		<cfif Len(arguments.patches)>
			<cfset patchObj = createObject("java","java.io.File").init(arguments.patches) />
			<!--- If using the FileExtensionFilter --->
			<cfset patchFileFilter = createObject("java","FileExtensionFilter").init(".xml") />
			<cfset patchArray = patchObj.listFiles(patchFileFilter) />
			<!--- If not using the FileExtensionFilter, comment lines 49 and 50 and uncomment line 53 --->
			<!--- 
			<cfset patchArray = patchObj.listFiles() />
			--->
			<cfset wurflHolder = createObject("java","net.sourceforge.wurfl.core.CustomWURFLHolder").init(wurflObj,patchArray) />
		<cfelse>
			<cfset wurflHolder = createObject("java","net.sourceforge.wurfl.core.CustomWURFLHolder").init(wurflObj) />
		</cfif>
		
		<cfset setManager(wurflHolder.getWURFLManager()) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getCapability" displayname="Get Capability" hint="Given a userAgent and capability name, return the capabilities of the device" access="public" output="false" returntype="Any">
		<cfargument name="userAgent" displayname="User Agent" type="string" hint="User Agent for the request" required="true" />
		<cfargument name="capable" displayName="Capability" type="String" hint="Capability string that should be analyzed and returned" required="false" default="" />
		
		<cfset var thisDevice = "" />
		
		<cfif Len(Trim(arguments.userAgent)) gt 0>
			<cfset thisDevice = getManager().getDeviceForRequest(Trim(arguments.userAgent)) />
		<cfelse>
			<cfthrow message="You must provide a user agent." />
		</cfif>
		
		<cfif Len(Trim(arguments.capable)) gt 0>
			<cfreturn thisDevice.getCapability(Trim(arguments.capable)) />
		<cfelse>
			<cfreturn thisDevice.getCapabilities() />
		</cfif>
	</cffunction>
	
	<cffunction name="getMarkup" displayname="Get Markup" hint="Given a userAgent, return what kind of markup the device wants" access="public" output="false" returntype="string">
		<cfargument name="userAgent" displayname="User Agent" type="string" hint="User Agent for the request" required="true" />
				
		<cfset var thisDevice = "" />
		
		<cfif Len(Trim(arguments.userAgent)) gt 0>
			<cfset thisDevice = getManager().getDeviceForRequest(Trim(arguments.userAgent)) />
		<cfelse>
			<cfthrow message="You must provide a user agent." />
		</cfif>
		
		<cfreturn thisDevice.getMarkUp().toString() />
	</cffunction>

	<cffunction name="getPatches" access="public" output="false" returntype="string">
		<cfreturn variables.patches />
	</cffunction>
	
	<cffunction name="setPatches" access="private" output="false" returntype="void">
		<cfargument name="patchDirectory" type="string" required="true" />
		
		<cfset variables.patches = arguments.patchDirectory />
	</cffunction>

	<cffunction name="getWurfl" access="public" output="false" returntype="string">
		<cfreturn variables.wurfl />
	</cffunction>
	
	<cffunction name="setWurfl" access="private" output="false" returntype="void">
		<cfargument name="wurflDirectory" type="string" required="true" />
		
		<cfset variables.wurfl = arguments.wurflDirectory />
	</cffunction>
	
	<cffunction name="getManager" access="public" output="false" returntype="any">
		<cfreturn variables.manager />
	</cffunction>
	
	<cffunction name="setManager" access="private" output="false" returntype="void">
		<cfargument name="wurflHolder" type="any" required="true" />
		
		<cfset variables.manager = arguments.wurflHolder />
	</cffunction>

</cfcomponent>