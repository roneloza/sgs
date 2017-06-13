//
//  FileWebViewController.m
//  sgs
//
//  Created by rone loza on 5/22/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "FileWebViewController.h"
#import "ShareManager.h"

@interface FileWebViewController ()<UIWebViewDelegate>

@end

@implementation FileWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *commonMIMETypes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"audio/basic", @"au",
                                     @"video/msvideo, video/avi, video/x-msvideo", @"avi",
                                     @"image/bmp", @"bmp",
                                     @"application/x-bzip2", @"bz2",
                                     @"text/css", @"css",
                                     @"application/xml-dtd", @"dtd",
                                     @"application/msword", @"doc",
                                     @"application/vnd.openxmlformats-officedocument.wordprocessingml.document", @"docx",
                                     @"application/vnd.openxmlformats-officedocument.wordprocessingml.template", @"dotx",
                                     @"application/ecmascript", @"es",
                                     @"application/octet-stream", @"exe",
                                     @"image/gif", @"gif",
                                     @"application/x-gzip", @"gz",
                                     @"application/mac-binhex40", @"hqx",
                                     @"text/html", @"html",
                                     @"application/java-archive", @"jar",
                                     @"image/jpeg", @"jpg",
                                     @"application/x-javascript", @"js",
                                     @"audio/x-midi", @"midi",
                                     @"audio/mpeg", @"mp3",
                                     @"video/mpeg", @"mpeg",
                                     @"audio/vorbis, application/ogg", @"ogg",
                                     @"application/pdf", @"pdf",
                                     @"application/x-perl", @"pl",
                                     @"image/png", @"png",
                                     @"application/vnd.openxmlformats-officedocument.presentationml.template", @"potx",
                                     @"application/vnd.openxmlformats-officedocument.presentationml.slideshow", @"ppsx",
                                     @"application/vnd.ms-powerpointtd>", @"ppt",
                                     @"application/vnd.openxmlformats-officedocument.presentationml.presentation", @"pptx",
                                     @"application/postscript", @"ps",
                                     @"video/quicktime", @"qt",
                                     @"audio/x-pn-realaudio, audio/vnd.rn-realaudio", @"ra",
                                     @"audio/x-pn-realaudio, audio/vnd.rn-realaudio", @"ram",
                                     @"application/rdf, application/rdf+xml", @"rdf",
                                     @"application/rtf", @"rtf",
                                     @"text/sgml", @"sgml",
                                     @"application/x-stuffit", @"sit",
                                     @"application/vnd.openxmlformats-officedocument.presentationml.slide", @"sldx",
                                     @"image/svg+xml", @"svg",
                                     @"application/x-shockwave-flash", @"swf",
                                     @"application/x-tar", @"tar.gz",
                                     @"application/x-tar", @"tgz",
                                     @"image/tiff", @"tiff",
                                     @"text/tab-separated-values", @"tsv",
                                     @"text/plain", @"txt",
                                     @"audio/wav, audio/x-wav", @"wav",
                                     @"application/vnd.ms-excel.addin.macroEnabled.12", @"xlam",
                                     @"application/vnd.ms-excel", @"xls",
                                     @"application/vnd.ms-excel.sheet.binary.macroEnabled.12", @"xlsb",
                                     @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", @"xlsx",
                                     @"application/vnd.openxmlformats-officedocument.spreadsheetml.template", @"xltx",
                                     @"application/xml", @"xml",
                                     @"application/zip, application/x-compressed-zip", @"zip",
                                     nil];
    
    
    NSData *fileData = [[NSData alloc] initWithContentsOfURL:self.urlFile options:(NSDataReadingMapped) error:nil];
    
    NSString *ext = [[self.urlFile pathExtension] lowercaseString];
    
    NSString *MIMEType = [commonMIMETypes valueForKey:ext];
    
    MIMEType = MIMEType ? MIMEType : @"text/html";
    
    
    if ([ext isEqualToString:@"png"] ||
        [ext isEqualToString:@"jpg"] ||
        [ext isEqualToString:@"jpeg"] ||
        [ext isEqualToString:@"bmp"] ||
        [ext isEqualToString:@"gif"]) {
        
        self.webView.backgroundColor = [UIColor blackColor];
        self.webView.opaque = NO;
    }
    else {
        
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.opaque = NO;
    }
    
    [self.webView loadData:fileData
                  MIMEType:MIMEType
          textEncodingName:@"UTF-8"
                   baseURL:[NSURL URLWithString:@""]];
    
    self.webView.delegate = self;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *ext = [self.urlFile pathExtension];
    
    if ([ext isEqualToString:@"png"] ||
        [ext isEqualToString:@"jpg"] ||
        [ext isEqualToString:@"jpeg"] ||
        [ext isEqualToString:@"bmp"] ||
        [ext isEqualToString:@"gif"]) {
     
//    position: absolute;
//    left: 50%;
//    left: 50%;
//        margin-left: -150px;
//        margin-left: -150px;

        NSString *javaScript =
        @"document.getElementsByTagName('img')[0].style.position = 'absolute';"
        "document.getElementsByTagName('img')[0].style.top = '50%';"
        "document.getElementsByTagName('img')[0].style.margin = -(document.getElementsByTagName('img')[0].height / 2) +  ' 0 0 0';";
        
        [self.webView stringByEvaluatingJavaScriptFromString:javaScript];
        
        //    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:
        //                      @"document.body.innerHTML"];
        //    
        //    NSLog(@"%@", html);
        
    }
}

- (void)setupLabels {
    
    [super setupLabels];
//    self.navigationController.navigationBar.topItem.title = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    //    NSString *bodyStyle = @"document.getElementsByTagName('body')[0].style.textAlign = 'center';";
    
    
    //position: absolute;
    //top: 50%;
    //left: 50%;
    //margin: -50px 0 0 -50px;
    
//    NSString *javaScript1 = @"document.getElementsByTagName('img')[0].style.position = 'absolute';";
//    NSString *javaScript2 = @"document.getElementsByTagName('img')[0].style.top = '25%';";
//    NSString *javaScript3 = @"document.getElementsByTagName('img')[0].style.left = '0%';";
//    
//    [self.webView stringByEvaluatingJavaScriptFromString:javaScript1];
//    [self.webView stringByEvaluatingJavaScriptFromString:javaScript2];
//    [self.webView stringByEvaluatingJavaScriptFromString:javaScript3];
    
//    var css = document.createElement("style");
//    css.type = "text/css";
//    css.innerHTML = "strong { color: red }";
//    document.body.appendChild(css);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareBarButtonPressed:(id)sender {
    
    __weak FileWebViewController *wkself = self;
    
    [[ShareManager class] shareUrlFile:wkself.urlFile inViewController:wkself barButtonItem:sender completion:nil];
}

@end
