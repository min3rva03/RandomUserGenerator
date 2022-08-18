# Random User Generator

Este proyecto muestra de forma aleatoria el perfil de personas alrededor del mundo , permite conocer los datos personales de cada una de ellas y su ubicacion.
Esta informacion se puede conocer a traves del API (https://randomuser.me/api/)
                
# Estructura del proyecto

El proyecto se organiza de la siguiente manera:

**Helpers** contiene la clase *Bindable* encargada de escuchar el cambio de valores en el Modelo y pasarla al controller.

**ServiceManager** Es la clase mediante la cuál se realiza el consumo del API.

En su método *sendRequest* recibe la URL a la que se consultara. Implementa ademas el protocolo *ServiceManagerDelegate* al que una vez realizada la consulta llama a su método *serviceResponse*  y le proporciona el ResponseData de la consulta, este internamente llama al mètodo *setUsrDefaults* del ViewModel que se encarga de almacenar esta respuesta en **user defaults** 
Esta clase tambien contiene una función llamada *sendRequestWithClosure* que no es mas que otra forma de realizar la consulta al API,  se dejo comentada en el codigo como referencia de que puede realizarse lo mismo con delegados o closures.

**RandomUsrGeneratorModule** Contiene la implementación de la arquitectura **MVVM**

-    **Model** 
                *RandomUsrGeneratorModel* Contiene el modelo de datos con los campos que devuelve el API y que la aplicacion desea mostrar , estos datos son: nombre, genero, edad, email y telefono, asi como latitud ylongitud que son necesarios para conocer la ubicacion.
                
-    **View**
- *IssLocatorController* Mediante la implementación de GoogleMaps nos permitirá conocer la posición de la ISS en el mapa.
                        para hacer uso del mapa esta clase declara una constante llamada camera que recibe tres valores : latitud , longitud y zoom  que permite conocer la posición en el mapa y una constante mapView que es la vista sobre la cuál se muestra el mapa.
                        Implementa un timer que cada 10 segundos solicita al ViewModel se consulte la ubicación, esto mediante
                        
- *self.issLocatorVM.requestLocation()*
                        Tambien se implementa un marcador que permite conocer la ubicación de la ISS de manerá visual.
                        Adicional a esto cabe mencionar que al final de la clase se observa el método *rightBarButtonTapped* que realiza la navegación entre una pantalla (la del mapa) y la pantalla del listado de ubicaciones (botón derecho del TabBar).
                        
- *IssLocatorTableController* Esta clase muestra el registro de las ultimas ubicaciones. Implementa los métodos del delegado *UITableViewDelegate*  y *UITableViewDataSource* para obtener el numero de secciones y celdas que va a mostrar  , asi como la información que mostrará en cada una.
                  Para obtener el numero de registros consulta al IssLocatorViewModel en su método *getnumberOfRows()* que internamente consulta el método *getUsrDefaults()* para conocer el número de registros almacenados en User Defaults.
                  Para conocer y mostrar la información de las ultimas ubicaciones se consulta nuevamente el ViewModel en su método getCellForRow que consulta los registros de user Defaults y permite mostrar la latitud y longitud de las ubicaciones.
-    **ViewModel**
                *RandomUsrViewModel* Es el intermediario entre la vista y el modelo.
                Contiene la implementación de los métodos :
                    <func requestRandomUsrGenerate()> Hace uso del sendRequest del serviceManager proporcionando la URL(https://randomuser.me/api/) del Api a la que se realizará la consulta
                    <func serviceResponse()>    Añade a un array la respuesta del servicio
                    <func parseJSONUsrGenerator()>   Realiza el parseo de datos de la respuesta del servicio al modelo de datos
                    <func setUsrDefaults>       Almacena en user defaults los valores obtenidos del servicio
                    <func getInitialData()>     Proporciona a un array el registro de userDefaults obteniendolo del *getUsrDefaults*
                    <func removeUsrDefaults()>  Elimina todos los registros de userDefaults(funcionalidad que se agrego y que no fue implementada en dicho proyecto)
                    <func getUsrDefaults()>     Permite obtener los registros almacenados en user defaults
                    <func getnumberOfRows()>    Permite conocer el número de registros almacenados en el user defaults
                    <func getCellForRow()>      Permite obtener un registro de userDefaults en una posicion especifica
                    
**Resources** contiene las imagenes y colores utilizados en la aplicacion.
**Base** Contiene el diseño de launchScreen es decir lo que el usuario visualizara una vez iniciada la aplicacion
**Aplication** contiene la estructura de las vistas que conforman la aplicación de modo que resulte facil de entender.
-    **Main** 
                *Main* Contiene el diseño del tabBar asi como la relación de este con el Perfil y el historial
-    **OnBoarding** 
                *OnBoarding* Contiene el diseño del onBoarding junto con una breve explicacion de la aplicacion 
                *OnBoardingContainerViewController* Transición entre un viewController y otro 
                *OnBoardingStepsViewController* Relación de los elementos de la vista con el viewcontroller
                *OnBoardingViewController* Agrega los elementos requeridos por el OnBoardingStepsViewController y la animación entre ellos
-    **Profile** 
                *ProfileViewController* Utiliza el metodo requestRandomUsrGenerate() para realizar la petición al servico y una vez obtenida la respuesta dar valor a los elementos necesarios para mostrar los datos personales de personas de forma aleatoria
-    **History** 
                *HistoryViewController* Muestra el historial de las personas que hemos visualizado la foto y nombre de cada una de ellas
                
                
# Ejecución del proyecto

Clonar repositorio y compilar.
