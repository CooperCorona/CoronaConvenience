// Generated by Apple Swift version 3.0 (swiftlang-800.0.46.2 clang-800.0.38)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
@import AppKit;
@import CoreGraphics;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"

@interface NSFileManager (SWIFT_EXTENSION(CoronaConvenience))
/**
  Gets all files of a bundle with a given file extension.
  \param type The file extension (png, pdf, vsh)

  \param removeExtensions Whether to remove the file extensions in the returned array. Default value is true.


  returns:
  An array of all file paths with a given extension in the bundle.
*/
- (NSArray<NSURL *> * _Nonnull)allFilesOfType:(NSString * _Nonnull)type removeExtensions:(BOOL)removeExtensions;
/**
  Gets all files of a bundle with given file extensions.
  \param type An array containing the desired file extensions (png, pdf, vsh)

  \param removeExtensions Whether to remove the file extensions in the returned dictionary. Default value is true.


  returns:
  An dictionary of all file paths with given extensions in the bundle.
*/
- (NSDictionary<NSString *, NSString *> * _Nonnull)allFilesOfTypes:(NSArray<NSString *> * _Nonnull)types removeExtensions:(BOOL)removeExtensions;
- (NSURL * _Nullable)documentsDirectory;
+ (BOOL)fileExistsInDocuments:(NSString * _Nonnull)file fileExtension:(NSString * _Nonnull)fileExtension;
@end


@interface NSColor (SWIFT_EXTENSION(CoronaConvenience))
+ (NSColor * _Nonnull)violetColor;
+ (NSColor * _Nonnull)darkRedColor;
+ (NSColor * _Nonnull)darkGreenColor;
+ (NSColor * _Nonnull)darkBlueColor;
- (nonnull instancetype)initWithString:(NSString * _Nonnull)string;
- (NSArray<NSNumber *> * _Nonnull)getComponents;
- (NSArray<NSNumber *> * _Nonnull)getHSBComponents;
- (NSString * _Nonnull)getString;
/**
  Returns either black or white, whichever would show up better when displayed over this color.
*/
- (NSColor * _Nonnull)absoluteContrastingColor;
/**
  Lightens or darkens only the RGB values (not the alpha).
*/
- (NSColor * _Nonnull)scaleRGB:(CGFloat)factor;
@end

@class NSURL;

@interface NSImage (SWIFT_EXTENSION(CoronaConvenience))
+ (NSImage * _Nullable)imageWithPDFFile:(NSString * _Nonnull)file size:(CGSize)size;
+ (NSImage * _Nullable)imageWithPDFURL:(NSURL * _Nonnull)pdfURL size:(CGSize)size;
@end

@class OS_dispatch_queue;

@interface NSObject (SWIFT_EXTENSION(CoronaConvenience))
+ (void)dispatchAfter:(CGFloat)seconds onQueue:(OS_dispatch_queue * _Nonnull)queue withBlock:(void (^ _Nonnull)(void))block;
+ (void)dispatchAfter:(CGFloat)seconds withBlock:(void (^ _Nonnull)(void))block;
+ (void)dispatchAsyncMain:(void (^ _Nonnull)(void))block;
@end

@class NSTextCheckingResult;

@interface NSRegularExpression (SWIFT_EXTENSION(CoronaConvenience))
- (nullable instancetype)initWithRegex:(NSString * _Nonnull)regex;
- (NSArray<NSTextCheckingResult *> * _Nonnull)matchesInString:(NSString * _Nonnull)string;
- (NSArray<NSString *> * _Nonnull)matchedStringsInString:(NSString * _Nonnull)string;
@end


@interface NSNotificationCenter (SWIFT_EXTENSION(CoronaConvenience))
- (void)addObserver:(id _Nonnull)observer name:(NSString * _Nonnull)name selector:(SEL _Nonnull)selector;
+ (void)addObserver:(id _Nonnull)observer name:(NSString * _Nonnull)name selector:(SEL _Nonnull)selector;
+ (void)removeObserver:(id _Nonnull)observer name:(NSString * _Nonnull)name;
+ (void)removeObserver:(id _Nonnull)observer;
@end


@interface NSOperation (SWIFT_EXTENSION(CoronaConvenience))
- (void)addOptionalDependency:(NSOperation * _Nullable)operation;
@end


@interface NSScanner (SWIFT_EXTENSION(CoronaConvenience))
/**
  Returns a string, scanned as long as characters from a given character set are encountered, or \code
  nil
  \endcode if none are found.
*/
- (NSString * _Nullable)scanCharactersFromSet:(NSCharacterSet * _Nonnull)set;
/**
  Returns a string, scanned until a character from a given character set are encountered, or the remainder of the scanner’s string. Returns \code
  nil
  \endcode if the scanner is already \code
  atEnd
  \endcode.
*/
- (NSString * _Nullable)scanUpToCharactersFromSet:(NSCharacterSet * _Nonnull)set;
/**
  Returns the given string if scanned, or \code
  nil
  \endcode if not found.
*/
- (NSString * _Nullable)scanString:(NSString * _Nonnull)str;
/**
  Returns a string, scanned until the given string is found, or the remainder of the scanner’s string. Returns \code
  nil
  \endcode if the scanner is already \code
  atEnd
  \endcode.
*/
- (NSString * _Nullable)scanUpToString:(NSString * _Nonnull)str;
@end

@class NSKeyedArchiver;
@class NSKeyedUnarchiver;

SWIFT_CLASS("_TtC17CoronaConvenience18UniversalSaverBase")
@interface UniversalSaverBase : NSObject
@property (nonatomic, readonly, copy) NSString * _Nonnull fileName;
@property (nonatomic, readonly, copy) NSString * _Nonnull fileExtension;
@property (nonatomic, readonly, copy) NSString * _Nullable fileDirectory;
@property (nonatomic, readonly, copy) NSString * _Nonnull path;
- (nonnull instancetype)initWithFile:(NSString * _Nonnull)file fileExtension:(NSString * _Nonnull)fileExtension directory:(NSString * _Nullable)directory OBJC_DESIGNATED_INITIALIZER;
- (BOOL)save;
- (BOOL)load;
- (void)saveWithArchiver:(NSKeyedArchiver * _Nonnull)archive;
- (void)loadWithArchiver:(NSKeyedUnarchiver * _Nonnull)unarchive;
+ (NSString * _Nonnull)pathForFile:(NSString * _Nonnull)file fileExtension:(NSString * _Nonnull)fileExtension directory:(NSString * _Nullable)directory;
+ (BOOL)fileExistsAtPath:(NSString * _Nonnull)file fileExtension:(NSString * _Nonnull)fileExtension directory:(NSString * _Nullable)directory;
+ (NSString * _Nullable)pathForFileInDocumentsOrBundle:(NSString * _Nonnull)file fileExtension:(NSString * _Nonnull)fileExtension directory:(NSString * _Nullable)directory;
+ (void)createDirectoryAtPath:(NSString * _Nonnull)path;
+ (NSArray<NSURL *> * _Nonnull)contentsOfDirectory:(NSString * _Nonnull)directory removeExtensions:(BOOL)removeExtensions;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

#pragma clang diagnostic pop
