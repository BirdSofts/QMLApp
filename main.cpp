// *******************************************************************************************
/// <summary>
/// 
/// </summary>
/// <created>ʆϒʅ,18.09.2019</created>
/// <changed>ʆϒʅ,30.09.2019</changed>
// *******************************************************************************************


#include <qguiapplication.h>
//#include <qqmlapplicationengine.h> // not using a window
#include <qdir.h>
#include <qquickview.h>
#include <qqmlfileselector.h> // application without a window
#include <qqmlcontext.h>

#include "settings.h"


int main ( int argc, char* argv [] )
{
  QCoreApplication::setAttribute ( Qt::AA_EnableHighDpiScaling );

  QGuiApplication app ( argc, argv );

  app.setOrganizationName ( "BirdSofts" );
  app.setOrganizationDomain ( "https://github.com/BirdSofts/" );
  app.setApplicationName ( QFileInfo ( app.applicationFilePath () ).baseName () );

  QQuickView view;

  if (qgetenv ( "QT_QUICK_CORE_PROFILE" ).toInt ())
  {
    QSurfaceFormat surfaceFormat = view.format ();
    surfaceFormat.setProfile ( QSurfaceFormat::CoreProfile );
    surfaceFormat.setVersion ( 4, 4 );
    view.setFormat ( surfaceFormat );
  }

  if (qgetenv ( "QT_QUICK_MULTISAMPLE" ).toInt ())
  {
    QSurfaceFormat surfaceFormat = view.format ();
    surfaceFormat.setSamples ( 4 );
    view.setFormat ( surfaceFormat );
  }

  const QUrl url ( QStringLiteral ( "qrc:/main.qml" ) );

  view.connect ( view.engine (), &QQmlEngine::quit, &app, &QCoreApplication::quit );
  new QQmlFileSelector ( view.engine (), &view );

  Configuration configs;
  view.rootContext ()->setContextProperty ( "configuration", &configs );

  //view.setSource ( QUrl ( "qrc:///" #NAME ".qml" ) );
  view.setSource ( url );

  if (view.status () == QQuickView::Error)
    return-1;

  view.setResizeMode ( QQuickView::SizeRootObjectToView );

  view.show ();

  //QQmlApplicationEngine engine;
  //QObject::connect ( &engine, &QQmlApplicationEngine::objectCreated,
  //                   &app, [url] ( QObject* obj, const QUrl& objUrl ) {
  //                     if (!obj && url == objUrl)
  //                       QCoreApplication::exit ( -1 );
  //                   }, Qt::QueuedConnection );
  //engine.load ( url );

  return app.exec ();
}
