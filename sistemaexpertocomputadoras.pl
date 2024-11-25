% Opciones de componentes
opciones_procesador(['Intel Core i9', 'Intel Core i7', 'AMD Ryzen 9', 'AMD Ryzen 7', 'Intel Core i9-14900KF', 'AMD Ryzen 7 9700X']).
opciones_ram(['8GB', '16GB', '32GB', '64GB']).
opciones_almacenamiento(['256GB SSD', '512GB SSD', '1TB SSD', '2TB SSD']).
opciones_placa_base(['ASUS ROG Strix', 'MSI B450', 'Gigabyte Z490', 'ASRock B550', 'MSI MPG Z790 Wifi II']).
opciones_fuente_alimentacion(['500W', '650W', '750W', '850W']).
opciones_refrigeracion(['Aire', 'Liquida', 'Disipador']).

opcion(personalizada, 'Configurador personalizado en desarrollo...').

opcion_predisenada('Programacion', alta,
    ['Intel Core i9, 32GB RAM, 1TB SSD, Asus TUF RTX 4090',
     'AMD Ryzen 9, 32GB RAM, 1TB SSD, RTX 3080']).
opcion_predisenada('Programacion', media,
    ['Intel Core i7, 16GB RAM, 512GB SSD, GTX 1660',
     'AMD Ryzen 7, 16GB RAM, 512GB SSD, GTX 1660 Ti']).
opcion_predisenada('Programacion', baja,
    ['Intel Core i5-14400, 8GB RAM, 256GB SSD',
     'AMD Ryzen 5, 8GB RAM, 256GB SSD']).

opcion_predisenada('Gaming', alta,
    ['Intel Core i9-14900KF, 64GB RAM, 1TB SSD, RTX 4090',
     'AMD Ryzen 9, 32GB RAM, 1TB SSD, RTX 4090']).
opcion_predisenada('Gaming', media,
    ['Intel Core i7, 16GB RAM, 512GB SSD, RTX 3060',
     'AMD Ryzen 7, 16GB RAM, 512GB SSD, RTX 3060']).
opcion_predisenada('Gaming', baja,
    ['Intel Core i5, 8GB RAM, 256GB SSD',
     'AMD Ryzen 5, 8GB RAM, 256GB SSD']).

opcion_predisenada('Renderizado', alta,
    ['Intel Core i9 9a Gen, 64GB RAM, 2TB SSD, RTX 3090',
     'AMD Ryzen 9, 64GB RAM, 2TB SSD, RTX 3090']).
opcion_predisenada('Renderizado', media,
    ['Intel Core i7 6a Gen, 32GB RAM, 1TB SSD, RTX 2070',
     'AMD Ryzen 7 7700, 32GB RAM, 1TB SSD, RTX 2070']).
opcion_predisenada('Renderizado', baja,
    ['Intel Core i5, 16GB RAM, 512GB SSD, GTX 1660',
     'AMD Ryzen 5, 16GB RAM, 512GB SSD, GTX 1660']).

% Preguntar por cada componente con opciones
preguntar_componente(procesador, Respuesta) :-
    opciones_procesador(Opciones),
    write('Elige un procesador:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

preguntar_componente(ram, Respuesta) :-
    opciones_ram(Opciones),
    write('Elige la memoria RAM:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

preguntar_componente(almacenamiento, Respuesta) :-
    opciones_almacenamiento(Opciones),
    write('Elige el almacenamiento:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

preguntar_componente(placa_base, Respuesta) :-
    opciones_placa_base(Opciones),
    write('Elige la placa base:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

preguntar_componente(fuente_alimentacion, Respuesta) :-
    opciones_fuente_alimentacion(Opciones),
    write('Elige la fuente de alimentacion:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

preguntar_componente(refrigeracion, Respuesta) :-
    opciones_refrigeracion(Opciones),
    write('Elige la refrigeracion:'), nl,
    listar_opciones(Opciones),
    read(Opcion),
    nth1(Opcion, Opciones, Respuesta).

% Funcion para listar las opciones disponibles con indices
listar_opciones(Opciones) :-
    listar_opciones(Opciones, 1).

listar_opciones([], _).
listar_opciones([Opcion | Resto], Indice) :-
    write(Indice), write('. '), write(Opcion), nl,
    NuevoIndice is Indice + 1,
    listar_opciones(Resto, NuevoIndice).

% Sistema experto actualizado
sistema_experto :-
    write('Que tipo de computadora deseas?'), nl,
    write('1. Personalizada'), nl,
    write('2. Predisenada'), nl,
    read(Tipo),
    (
        Tipo == 1 ->
            configuracion_personalizada;
        Tipo == 2 ->
            configuracion_predisenada
    ).

% Configuración personalizada
configuracion_personalizada :-
    write('Configurador personalizado...'), nl,
    preguntar_componente(procesador, Procesador),
    preguntar_componente(ram, RAM),
    preguntar_componente(almacenamiento, Almacenamiento),
    preguntar_componente(placa_base, PlacaBase),
    preguntar_componente(fuente_alimentacion, Fuente),
    preguntar_componente(refrigeracion, Refrigeracion),
    (evaluar_compatibilidad(Procesador, RAM, Almacenamiento, PlacaBase, Fuente, Refrigeracion, Compatibilidad) ->
        clasificar_uso(Procesador, RAM, Uso),
        resumen_final(Procesador, RAM, Almacenamiento, PlacaBase, Fuente, Refrigeracion, Uso, Compatibilidad);
        write('Los componentes seleccionados no son compatibles.'), nl).

% Evaluar compatibilidad
evaluar_compatibilidad(Procesador, RAM, Almacenamiento, PlacaBase, Fuente, Refrigeracion, Compatibilidad) :-
    (compatible_procesador_placabase(Procesador, PlacaBase) ->
        (compatible_ram_placabase(RAM, PlacaBase) ->
            (compatible_almacenamiento_placabase(Almacenamiento, PlacaBase) ->
                (suficiente_potencia(Fuente, Procesador, RAM, Almacenamiento, PlacaBase, Refrigeracion) ->
                    (refrigeracion_adecuada(Refrigeracion, Procesador) ->
                        Compatibilidad = 'Compatible';
                        write('Refrigeracion inadecuada.'), nl, fail);
                    write('Advertencia : Potencia insuficiente.'), nl);
                write('Almacenamiento incompatible.'), nl, fail);
            write('RAM incompatible.'), nl, fail);
        write('Procesador y placa base incompatibles.'), nl, fail).


% Compatibilidad de procesador y placa base
compatible_procesador_placabase('Intel Core i9', 'ASUS ROG Strix').
compatible_procesador_placabase('Intel Core i7', 'ASUS ROG Strix').
compatible_procesador_placabase('AMD Ryzen 7', 'ASUS ROG Strix').
compatible_procesador_placabase('AMD Ryzen 9', 'ASUS ROG Strix').
compatible_procesador_placabase('Intel Core i7', 'Gigabyte Z490').
compatible_procesador_placabase('AMD Ryzen 9', 'MSI B450').
compatible_procesador_placabase('AMD Ryzen 7', 'ASRock B550').
compatible_procesador_placabase('Intel Core i9', 'Gigabyte Z490').
compatible_procesador_placabase('Intel Core i7',  'MSI B450').
compatible_procesador_placabase('Intel Core i9-14900KF', 'ASUS ROG Strix').
compatible_procesador_placabase('Intel Core i9-14900KF', 'Gigabyte Z490').
compatible_procesador_placabase('Intel Core i9-14900KF', 'MSI B450').
compatible_procesador_placabase('Intel Core i9-14900KF', 'ASRock B550').
compatible_procesador_placabase('Intel Core i9-14900KF', 'MSI MPG Z790 Wifi II').

compatible_procesador_placabase('AMD Ryzen 7 9700X', 'ASUS ROG Strix').
compatible_procesador_placabase('AMD Ryzen 7 9700X', 'Gigabyte Z490').
compatible_procesador_placabase('AMD Ryzen 7 9700X', 'MSI B450').
compatible_procesador_placabase('AMD Ryzen 7 9700X', 'ASRock B550').
compatible_procesador_placabase('AMD Ryzen 7 9700X', 'MSI MPG Z790 Wifi II').

% Compatibilidad de RAM y placa base
compatible_ram_placabase('8GB', 'ASUS ROG Strix').
compatible_ram_placabase('16GB', 'ASUS ROG Strix').
compatible_ram_placabase('32GB', 'ASUS ROG Strix').
compatible_ram_placabase('64GB', 'ASUS ROG Strix').

compatible_ram_placabase('8GB', 'MSI MPG Z790 Wifi II').
compatible_ram_placabase('16GB', 'MSI MPG Z790 Wifi II').
compatible_ram_placabase('32GB', 'MSI MPG Z790 Wifi II').
compatible_ram_placabase('64GB', 'MSI MPG Z790 Wifi II').

compatible_ram_placabase('8GB', 'Gigabyte Z490').
compatible_ram_placabase('16GB', 'Gigabyte Z490').
compatible_ram_placabase('32GB', 'Gigabyte Z490').
compatible_ram_placabase('64GB', 'Gigabyte Z490').

compatible_ram_placabase('32GB', 'ASRock B550').
compatible_ram_placabase('64GB', 'ASRock B550').

compatible_ram_placabase('32GB', 'MSI B450').
compatible_ram_placabase('64GB', 'MSI B450').

% Compatibilidad de almacenamiento y placa base
compatible_almacenamiento_placabase('256GB SSD', 'ASUS ROG Strix').
compatible_almacenamiento_placabase('512GB SSD', 'ASUS ROG Strix').
compatible_almacenamiento_placabase('1TB SSD', 'ASUS ROG Strix').
compatible_almacenamiento_placabase('2TB SSD', 'ASUS ROG Strix').

compatible_almacenamiento_placabase('256GB SSD', 'MSI MPG Z790 Wifi II').
compatible_almacenamiento_placabase('512GB SSD', 'MSI MPG Z790 Wifi II').
compatible_almacenamiento_placabase('1TB SSD', 'MSI MPG Z790 Wifi II').
compatible_almacenamiento_placabase('2TB SSD', 'MSI MPG Z790 Wifi II').

compatible_almacenamiento_placabase('256GB SSD', 'Gigabyte Z490').
compatible_almacenamiento_placabase('512GB SSD', 'Gigabyte Z490').
compatible_almacenamiento_placabase('1TB SSD', 'Gigabyte Z490').
compatible_almacenamiento_placabase('2TB SSD', 'Gigabyte Z490').

compatible_almacenamiento_placabase('256GB SSD', 'MSI B450').
compatible_almacenamiento_placabase('512GB SSD', 'MSI B450').

compatible_almacenamiento_placabase('256GB SSD', 'ASRock B550').

% Comprobacion de potencia suficiente
suficiente_potencia('500W', 'Intel Core i9', '8GB', '256GB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('650W', 'Intel Core i9', '16GB', '512GB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('750W', 'Intel Core i9', '32GB', '1TB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('850W', 'Intel Core i9', '64GB', '2TB SSD', 'ASUS ROG Strix', 'Liquida').

suficiente_potencia('650W', 'Intel Core i7', '16GB', '512GB SSD', 'Gigabyte Z490', 'Aire').
suficiente_potencia('500W', 'Intel Core i9', '16GB', '512GB SSD', 'ASUS ROG Strix', 'Liquida').

suficiente_potencia('500W', 'AMD Ryzen 9', '8GB', '256GB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('650W', 'AMD Ryzen 9', '16GB', '512GB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('750W', 'AMD Ryzen 9', '32GB', '1TB SSD', 'ASUS ROG Strix', 'Liquida').
suficiente_potencia('850W', 'AMD Ryzen 9', '64GB', '2TB SSD', 'ASUS ROG Strix', 'Liquida').

suficiente_potencia('500W', 'Intel Core i9-14900KF', '8GB', '256GB SSD', 'MSI MPG Z790 Wifi II', 'Liquida').
suficiente_potencia('650W', 'Intel Core i9-14900KF', '16GB', '512GB SSD', 'MSI MPG Z790 Wifi II', 'Liquida').
suficiente_potencia('750W', 'Intel Core i9-14900KF', '32GB', '1TB SSD', 'MSI MPG Z790 Wifi II', 'Liquida').
suficiente_potencia('850W', 'Intel Core i9-14900KF', '64GB', '2TB SSD', 'MSI MPG Z790 Wifi II', 'Liquida').

suficiente_potencia('650W', 'AMD Ryzen 7', '16GB', '512GB SSD', 'Gigabyte Z490', 'Aire').
suficiente_potencia('500W', 'AMD Ryzen 7', '16GB', '512GB SSD', 'ASUS ROG Strix', 'Liquida').

% Comprobacion computadoras economicas
computadoras_economicas('500W', 'AMD Ryzen 7', '8GB', '256GB SSD', 'ASRock B550', 'Aire').
computadoras_economicas('500W', 'AMD Ryzen 7', '16GB', '512GB SSD', 'Gigabyte Z490', 'Disipador').
computadoras_economicas('650W', 'Intel Core i7', '8GB', '256GB SSD', 'ASRock B550', 'Aire').
computadoras_economicas('650W', 'Intel Core i7', '16GB', '512GB SSD', 'Gigabyte Z490', 'Disipador').
computadoras_economicas('500W', 'AMD Ryzen 7', '8GB', '512GB SSD', 'Gigabyte Z490', 'Aire').

% Refrigeracion adecuada
refrigeracion_adecuada('Liquida', 'Intel Core i9').
refrigeracion_adecuada('Aire', 'Intel Core i7').
refrigeracion_adecuada('Disipador', 'Intel Core i7').
refrigeracion_adecuada('Liquida', 'Intel Core i7').
refrigeracion_adecuada('Liquida', 'AMD Ryzen 9').
refrigeracion_adecuada('Liquida', 'AMD Ryzen 7').
refrigeracion_adecuada('Aire', 'AMD Ryzen 7').
refrigeracion_adecuada('Aire', 'AMD Ryzen 9').
refrigeracion_adecuada('Liquida', 'Intel Core i9-14900KF').
refrigeracion_adecuada('Aire', 'Intel Core i9-14900KF').

refrigeracion_adecuada('Aire', 'AMD Ryzen 7 9700X').
refrigeracion_adecuada('Disipador', 'AMD Ryzen 7 9700X').
refrigeracion_adecuada('Liquida', 'AMD Ryzen 7 9700X').

% Clasificar gama y uso
clasificar_uso(Procesador, RAM, Uso) :-
    recomendar_uso(Procesador, RAM, Uso).

% Recomendaciones de uso
recomendar_uso(Procesador, RAM, Uso) :-
    (Procesador = 'Intel Core i9', RAM = '32GB' -> Uso = 'Gaming y Renderizado';
     Procesador = 'AMD Ryzen 9', RAM = '32GB' -> Uso = 'Gaming y Renderizado';
     Procesador = 'Intel Core i7', RAM = '16GB' -> Uso = 'Programación';
     Procesador = 'AMD Ryzen 7', RAM = '16GB' -> Uso = 'Programación';
     Uso = 'Uso general').


% Resumen final
resumen_final(Procesador, RAM, Almacenamiento, PlacaBase, Fuente, Refrigeracion, Uso, Compatibilidad) :-
    format('Resumen de la configuracion personalizada:\n'),
    format('Procesador: ~w\n', [Procesador]),
    format('Memoria RAM: ~w\n', [RAM]),
    format('Almacenamiento: ~w\n', [Almacenamiento]),
    format('Placa base: ~w\n', [PlacaBase]),
    format('Fuente de alimentacion: ~w\n', [Fuente]),
    format('Refrigeracion: ~w\n', [Refrigeracion]),
    format('Uso recomendado: ~w\n', [Uso]),
    format('Compatibilidad: ~w\n', [Compatibilidad]).

% Configuracion predisenada
configuracion_predisenada :-
    write('¿Para que la necesitas?'), nl,
    write('1. Programacion'), nl,
    write('2. Gaming'), nl,
    write('3. Renderizado'), nl,
    read(Campo),
    (
        Campo == 1 -> CampoElegido = 'Programacion';
        Campo == 2 -> CampoElegido = 'Gaming';
        Campo == 3 -> CampoElegido = 'Renderizado';
        write('Opcion no valida.'), nl, fail
    ),
    write('¿Que gama prefieres?'), nl,
    write('1. Alta'), nl,
    write('2. Media'), nl,
    write('3. Baja'), nl,
    read(Gama),
    (
        Gama == 1 -> GamaElegida = alta;
        Gama == 2 -> GamaElegida = media;
        Gama == 3 -> GamaElegida = baja;
        write('Opcion no valida.'), nl, fail
    ),
    opcion_predisenada(CampoElegido, GamaElegida, Opciones),
    write('Opciones disponibles:'), nl,
    listar_opciones(Opciones).
