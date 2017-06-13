//
//  MenuDetailItem.m
//  sgs
//
//  Created by Rone Loza on 4/28/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "MenuDetailItem.h"

@implementation MenuDetailItem

- (instancetype)init {
    
    if ((self = [super init])) {
    
        _columns = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)setColumna01:(NSString *)columna01 {
    
    if (columna01) {
        
        _columna01 = columna01;
        Item *item = [[Item alloc] initWithTitle:_columna01];
        item.methodName = NSStringFromSelector(_cmd);
        
        [self.columns addObject:item];
    }
}

- (void)setColumna02:(NSString *)columna02 {
    
    if (columna02) {
        
        _columna02 = columna02;
        Item *item = [[Item alloc] initWithTitle:_columna02];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna03:(NSString *)columna03 {
    
    if (columna03) {
        
        _columna03 = columna03;
        Item *item = [[Item alloc] initWithTitle:_columna03];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna04:(NSString *)columna04 {
    
    if (columna04) {
        
        _columna04 = columna04;
        Item *item = [[Item alloc] initWithTitle:_columna04];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna05:(NSString *)columna05 {
    
    if (columna05) {
        
        _columna05 = columna05;
        Item *item = [[Item alloc] initWithTitle:_columna05];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna06:(NSString *)columna06 {
    
    if (columna06) {
        
        _columna06 = columna06;
        Item *item = [[Item alloc] initWithTitle:_columna06];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna07:(NSString *)columna07 {
    
    if (columna07) {
        
        _columna07 = columna07;
        Item *item = [[Item alloc] initWithTitle:_columna07];
        item.methodName = NSStringFromSelector(_cmd);
        
        [self.columns addObject:item];
    }
}

- (void)setColumna08:(NSString *)columna08 {
    
    if (columna08) {
        
        _columna08 = columna08;
        Item *item = [[Item alloc] initWithTitle:_columna08];
        item.methodName = NSStringFromSelector(_cmd);
        
        [self.columns addObject:item];
    }
}

- (void)setColumna09:(NSString *)columna09 {
    
    if (columna09) {
        
        _columna09 = columna09;
        Item *item = [[Item alloc] initWithTitle:_columna09];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna10:(NSString *)columna10 {
    
    if (columna10) {
        
        _columna10 = columna10;
        Item *item = [[Item alloc] initWithTitle:_columna10];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna11:(NSString *)columna11 {
    
    if (columna11) {
        
        _columna11 = columna11;
        Item *item = [[Item alloc] initWithTitle:_columna11];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna12:(NSString *)columna12 {
    
    if (columna12) {
        
        _columna12 = columna12;
        Item *item = [[Item alloc] initWithTitle:_columna12];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna13:(NSString *)columna13 {
    
    if (columna13) {
        
        _columna13 = columna13;
        Item *item = [[Item alloc] initWithTitle:_columna13];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna14:(NSString *)columna14 {
    
    if (columna14) {
        
        _columna14 = columna14;
        Item *item = [[Item alloc] initWithTitle:_columna14];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna15:(NSString *)columna15 {
    
    if (columna15) {
        
        _columna15 = columna15;
        Item *item = [[Item alloc] initWithTitle:_columna15];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna16:(NSString *)columna16 {
    
    if (columna16) {
        
        _columna16 = columna16;
        Item *item = [[Item alloc] initWithTitle:_columna16];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna17:(NSString *)columna17 {
    
    if (columna17) {
        
        _columna17 = columna17;
        Item *item = [[Item alloc] initWithTitle:_columna17];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna18:(NSString *)columna18 {
    
    if (columna18) {
        
        _columna18 = columna18;
        Item *item = [[Item alloc] initWithTitle:_columna18];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna19:(NSString *)columna19 {
    
    if (columna19) {
        
        _columna19 = columna19;
        Item *item = [[Item alloc] initWithTitle:_columna19];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumna20:(NSString *)columna20 {
    
    if (columna20) {
        
        _columna20 = columna20;
        Item *item = [[Item alloc] initWithTitle:_columna20];
        item.methodName = NSStringFromSelector(_cmd);
        [self.columns addObject:item];
    }
}

- (void)setColumns:(NSMutableArray *)columns {
    
    if (columns) {
        
        _columns = columns;
    }
}

//- (id)copyWithZone:(NSZone *)zone {
//    
//    MenuDetailItem *objectCopy = [[MenuDetailItem allocWithZone: zone] init];
//    
//    objectCopy.idpais = _idpais;
//    objectCopy.ididioma = _ididioma;
//    objectCopy.valorbusqueda = _valorbusqueda;
//    objectCopy.pagina = _pagina;
//    objectCopy.idusuario = _idusuario;
//    objectCopy.idmenu = _idmenu;
//    objectCopy.idmenudetalle = _idmenudetalle;
//    objectCopy.booladjunto = _booladjunto;
//    objectCopy.boolimportante = _boolimportante;
//    
//    objectCopy.columna01 = _columna01;
//    objectCopy.columna02 = _columna02;
//    objectCopy.columna03 = _columna03;
//    objectCopy.columna04 = _columna04;
//    objectCopy.columna05 = _columna05;
//    objectCopy.columna06 = _columna06;
//    objectCopy.columna07 = _columna07;
//    objectCopy.columna08 = _columna08;
//    objectCopy.columna09 = _columna09;
//    objectCopy.columna10 = _columna10;
//    objectCopy.columna11 = _columna11;
//    objectCopy.columna12 = _columna12;
//    objectCopy.columna13 = _columna13;
//    objectCopy.columna14 = _columna14;
//    objectCopy.columna15 = _columna15;
//    objectCopy.columna16 = _columna16;
//    objectCopy.columna17 = _columna17;
//    objectCopy.columna18 = _columna18;
//    objectCopy.columna19 = _columna19;
//    objectCopy.columna20 = _columna20;
//    
//    objectCopy.result = _result;
//    objectCopy.mensaje = _mensaje;
//    
//    objectCopy.columns = _columns;
//    
//    return objectCopy;
//}

@end
