<cfcomponent>
<cffunction name="createClass" access="private" returntype="any" output="false"
   hint="This will create a Java class from a file location. The class does not have to be in the class path.">
   <cfargument name="path" hint="An string of directories, or paths to .jar files to load into the classloader" type="string" required="true">
   <cfargument name="className" hint="The name of the class to create" type="string" required="Yes">
   <cfargument name="parentClassLoader" hint="(Expert use only) The parent java.lang.ClassLoader to set when creating the URLClassLoader" type="any" default="#getClass().getClassLoader()#" required="false">
   <cfscript>
      var oArray = createObject("java", "java.lang.reflect.Array");
      var oClass = createObject("java", "java.lang.Class");
      var aURLs = oArray.newInstance(oClass.forName("java.net.URL"), javaCast("int", 1));
      var oFile = createObject("java", "java.io.File").init(arguments.path);
      var oURLClassLoader = 0;
      if( NOT oFile.exists() ) throw("PathNotFoundException", "The path you have specified could not be found", oFile.getAbsolutePath() & " does not exist.");
      oArray.set(aURLs, javaCast("int", 0), oFile.toURL());
      //pass in the system loader
      oURLClassLoader = createObject("java", "java.net.URLClassLoader").init(aURLs, arguments.parentClassLoader);
      return createObject("java", "coldfusion.runtime.java.JavaProxy").init( oURLClassLoader.loadClass(arguments.className) );
   </cfscript>
</cffunction>
</cfcomponent>