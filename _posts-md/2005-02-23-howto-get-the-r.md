---
layout: post
title: HOWTO get the Real, Physical Path from linkedResources (IPath)
published: true
---
The plugin I'm working on involves environments inside and outside (Ant, via ILauncher) of Eclipse. So, resolving classpath set by IProject is a bit tricky - especially if there's a linkedResource defined in the .project file. The mountains of similar APIs wasted my whole afternoon.. [getLocation](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/resources/IResource.html#getLocation())(), [getRawLocation](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/resources/IResource.html#getRawLocation())(), [getFullPath](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/resources/IFile.html#getFullPath())(), [toString](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/runtime/IPath.html#toString())(), [toFile](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/runtime/IPath.html#toFile())(), [toOSString](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/reference/api/org/eclipse/core/runtime/IPath.html#toOSString())()... geez, there's so many of them - its all freakin useless! Reminds me of all the zillions of similar toDate functions I used to have to work with! -shiver-  
  
The actual documentation is found at [IBM](http://help.eclipse.org/help30/topic/org.eclipse.platform.doc.isv/guide/resInt_linked.htm). But _bah.._ after several hours.. and IPathVariableManager seem impotent, regardless of how I interrogate it. So, my own most trustworthy way of getting the ACTUAL, PHYSICAL path of any IPath is to use IWorkspaceRoot:

IProject proj = ... ;   
 // you get this urself, if you have   
 // IResource, try IResource.getProject()  
IJavaProject javaProject =   
 JavaCore.create(proj);  
IClasspathEntry [] resolvedClasspaths =   
 javaProject.getResolvedClasspath(true);  
IWorkspaceRoot workspaceRoot =   
 ResourcesPlugin.getWorkspace().getRoot();  
  
for (int i = 0;   
 resolvedClasspaths != null && i \< resolvedClasspaths.length;   
 i++) {  
  
 IPath path = resolvedClasspaths[i].getPath();  
 URL url = path.toFile().toURL();  
 IFile file = workspaceRoot.getFile(path);  
 if (file != null &&   
 file.getLocation() != null &&   
 file.getLocation().toFile() != null) {  
  
 url = file.getLocation().toFile().toURL();  
 // resolves actual, physical path of linkedResource  
  
 }  
  
 // at this point, URL is definitely usable to create new AntClasspathEntry(url)  
 // that are resolveable by Launched ant tasks  
 antClassPathEntry = new AntClasspathEntry(url);  
}  

  
There!   
  
