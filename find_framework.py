#!python
import os
import shutil

# return the filename in the path without extension
def findFileName(path, ext):
  name = ''
  for projFile in os.listdir(path):
    # cocoapods will generate _Pods.xcodeproj as well
    if projFile.endswith(ext) and not projFile.startswith('_Pods'):
      name= projFile[:-len(ext):]
  return name

# WARNING!! No / in the end
def DirectoryOfThisScript():
  return os.path.dirname( os.path.abspath( __file__ ) )

def findProjectName(working_directory):
  projectName = findFileName(working_directory, '.xcodeproj')

  if len(projectName) <= 0:
    # cocoapod projects
    projectName = findFileName(working_directory, '.podspec')
  return projectName

def Subdirectories(directory):
  res = []
  for path, subdirs, files in os.walk(directory):
    for name in subdirs:
      item = os.path.join(path, name)
      res.append(item)
  return res

def sorted_ls(path):
    mtime = lambda f: os.stat(os.path.join(path, f)).st_mtime
    return list(sorted(os.listdir(path), key=mtime))

def FindDerivedDataPath( derivedDataPath, projectName ):
  simulatorPaths = ['Build/Intermediates/CodeCoverage/Products/Debug-iphonesimulator/', # if you enable CodeCoverage, the framework of test target will be put in coverage folder, strange
                    'Build/Intermediates/CodeCoverage/Products/Debug-iphoneos/',
                    'Build/Products/Debug-iphonesimulator/',
                    'Build/Products/Debug-iphoneos/']

  # search ~/Library/Developer/Xcode/DerivedData/ to find <project_name>-dliwlpgcvwijijcdxarawwtrfuuh
  derivedPath = sorted_ls(derivedDataPath)[::-1] # newest file first
  for productPath in derivedPath:
    if productPath.lower().startswith( projectName.lower() ):
      for simulatorPath in simulatorPaths:
        projectPath = os.path.join('', *[derivedDataPath, productPath, simulatorPath])
        if (len(projectPath) > 0) and os.path.exists(projectPath):
          return projectPath # the lastest product is what we want (really?)
  return ''

def linkDerivedDataPath( working_directory ):

  if not working_directory:
    return ""

  derivedDataPath = os.path.expanduser('~/Library/Developer/Xcode/DerivedData/')

  # find the project name
  projectName = findProjectName(working_directory)
  if len(projectName) <= 0:
    return ""

  # find the derived data path
  projectPath = FindDerivedDataPath( derivedDataPath, projectName )
  if (len(projectPath) <= 0) or not os.path.exists(projectPath):
    return ""

  print('source '+ projectPath)


  targetPath = derivedDataPath + projectName
  if (len(targetPath) > 0) and os.path.exists(targetPath):
    shutil.rmtree(targetPath)

  os.mkdir(targetPath)

  # iterate through all frameworks folders /Debug-iphonesimulator/xxx/xxx.framework
  for frameworkFolder in os.listdir(projectPath):
    frameworkPath = os.path.join('', projectPath, frameworkFolder)

    if not os.path.isdir(frameworkPath):
      continue

    # the framework name might be different than folder name
    # we need to iterate all frameworks
    for frameworkFile in os.listdir(frameworkPath):
      if frameworkFile.endswith('framework'):
        frameworkFullPath = os.path.join('', frameworkPath, frameworkFile)
        frameworkTargetPath = os.path.join('', targetPath, frameworkFile)
        os.symlink(frameworkFullPath, frameworkTargetPath)
  return targetPath

if __name__ == "__main__":

  working_directory = os.getcwd()
  res = linkDerivedDataPath( working_directory )
  print(res)

  # test build command
  # swift build -Xswiftc "-sdk" -Xswiftc "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios12.1-simulator"

  # print (FlagsForFile(""))

  # flags = [
  # '-D__IPHONE_OS_VERSION_MIN_REQUIRED=70000',
  # '-x',
  # 'objective-c',
  # '-ProductFrameworkInclude',
  # '-ProductFrameworkInclude',
  # '-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks',
  # '-ISUB./Pods/Headers/Public',
  # '-MMD',
  # ]

  # print IncludeClangInXCToolChain(flags, DirectoryOfThisScript())
  # print IncludeFlagsOfFrameworkHeaders( flags, DirectoryOfThisScript() )

  # # res = subdirectory( DirectoryOfThisScript())
  # flags = [
  # '-D__IPHONE_OS_VERSION_MIN_REQUIRED=70000',
  # '-x',
  # 'objective-c',
  # '-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/Frameworks',
  # '-ISUB./Pods/Headers/Public',
  # '-MMD',
  # ]

  # print (IncludeFlagsOfSubdirectory( flags, DirectoryOfThisScript() ))
  # res = IncludeFlagsOfSubdirectory( flags, DirectoryOfThisScript() )
  # escaped = []
  # for flag in res:
    # if " " not in flag:
      # escaped.append(flag)
  # print ' '.join(escaped)
