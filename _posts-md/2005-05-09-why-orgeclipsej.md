---
layout: post
title: Why org.eclipse.jdt.launching.DEFAULT_CLASSPATH is always TRUE? And more on
  launching Ant tasks programmatically...
published: true
---
DEFAULT\_CLASSPATH will matter to you if you're trying to launch a task using ILaunchConfigurationWorkingCopy using a separate JRE.  
  
To launch in a separate JVM, you'll have to first, get a JVM..

    
    
    ILaunchManager launchManager = DebugPlugin.getDefault().getLaunchManager();  
     ILaunchConfigurationType type = launchManager.getLaunchConfigurationType(IAntLaunchConfigurationConstants.ID\_ANT\_LAUNCH\_CONFIGURATION\_TYPE);  
     ILaunchConfigurationWorkingCopy workingCopy = type.newInstance(null, "Execute Ant Target");  
     IProject project = ...;  
     IVMInstall vm = JavaRuntime.getVMInstall((IJavaProject) project);  
     workingCopy.setAttribute( IJavaLaunchConfigurationConstants.ATTR\_VM\_INSTALL\_TYPE, vm.getVMInstallType().getId());  
     workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR\_VM\_INSTALL\_NAME, vm.getName());  
     // ... more codes..   
     workingCopy.launch(ILaunchManager.RUN\_MODE, new NullProgressMonitor());   
     // now this runs in separate JVM as ur Eclipse
    

Now, for my case I need to append quite a bit of classpath for my ant tasks to run, when NOT running as separate JVM, its relatively easy.. just modify the classpath set in the AntCorePlugin:  

    
    
    IAntClasspathEntry [] newUrls = ...;  
     AntCorePlugin.getPlugin().getPreferences().setAdditionalClasspathEntries(newUrls);  
     // and when u're done launching/launch has terminated.. just remember to reset it back  
     // its impolite to make permanent change to user's preference without asking you know..
    

However, the above method of modifying classpath doesn't work when you're intending to run as a separate JRE, we'll have to do with something called IMemento:  

    
    
    List mementoList = new ArrayList();  
     mementoList.add((new AntHomeClasspathEntry()).getMemento());  
     mementoList.add((new ContributedClasspathEntriesEntry()).getMemento());  
     mementoList.add(JavaRuntime.newArchiveRuntimeClasspathEntry(new Path(workingDir.getAbsolutePath())).getMemento());  
     // and more custom classpaths..   
     workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR\_CLASSPATH, mementoList);
    

But what I find is, that there's this attribute ATTR\_DEFAULT\_CLASSPATH that is always set to true. And when its true, the classpath that I've painstakingly assembled above doesn't apply, its value is always true even if I explicitly set:  

    
    
    workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR\_DEFAULT\_CLASSPATH, false);  
     workingCopy.launch(ILaunchManager.RUN\_MODE, new NullProgressMonitor());
    

Frustrating.   
  
Its only after debugging into Eclipse's plugin's source code (yippie! open source!) that I realise that somewhere inside workingCopy.launch itself, there's a call to AntUtil.migrateToNewClasspathFormat() that effectively screws up that attribute. I haven't dwell into more details.. so my current fix is simple, I preempt:  

    
    
    AntUtil.migrateToNewClasspathFormat(workingCopy);  
     workingCopy.setAttribute(IJavaLaunchConfigurationConstants.ATTR\_DEFAULT\_CLASSPATH, false);  
     workingCopy.launch(ILaunchManager.RUN\_MODE, new NullProgressMonitor());
    

Now, the value remains as false and my custom classpath takes effect.  
  
