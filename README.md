# UOC. Master en Ciència de Dades. Visualització de Dades
## PAC3. La Catalunya Petita (2022)

### Context del projecte
PAC3 de l’assignatura de Visualització de Dades del Màster en Ciència de Dades de la UOC, en la que es demana als alumnes la creació d’una visualització narrativa de temàtica lliure.

Vaig triar l’anàlisi de l’evolució de la població entre els anys 1975 i 2022 del que vaig considerar la Catalunya "petita", és a dir, municipis de menys de 3000 habitants, amb la intenció de validar dues hipòtesis a partir de les visualitzacions adients de les dades:

* La població a Catalunya tendeix a concentrar-se a les grans ciutats i zones properes.
* Com a conseqüència de les mesures excepcionals adoptades per fer front a la situació d’emergència sanitària per la covid-19 l’any 2020, hi ha un trasvàs de població de les zones més poblades de Catalunya a les menys poblades.

Per a validar la primera hipòtesi considero l’interval entre els anys 1975 i 2022, mentre que per a validar la segona considero l’interval entre els anys 2020 i 2022.

Durant el desenvolupament de l’activitat vaig plantejar una tercera hipòtesi. Com en el cas de les anteriors, espero validar-la a partir de les visualitzacions realitzades:

* El mite dels municipis petits: es tracta de municipis bàsicament agrícoles i envellits?

El treball inclòs en aquest projecte inclou, bàsicament, el procés de neteja i adequació de les dades amb llenguatge R per tal de crear les visualitzacions desitjades amb l’eina Flourish. [Enllaç al projecte](https://public.flourish.studio/story/1789298/)

#### Reptes

Un dels reptes més importants per a aquest projecte és la representació d’informació geogràfica en mapes. D'altra banda també s'ha hagut de gestionar l'agrupació de dades de diferents fonts, així com salvar la diferència de dates per les dades disponibles. En aquest darrer cas, s'han considerat del mateix dia dades del 31-12-2019 i del 01-01-2020.

#### Fonts de dades
Tots els datasets que s'han fet servir en aquest projecte s'han obtingut de fonts de dades obertes.

### Conclusions principals

* El nombre d'habitants en municipis de menys de 3000 habitants decreix en 60000 persones malgrat l'augment notable de població en el global de Catalunya.
* El nombre de municipis de menys de 3000 habitants també decreix, al 2020 n'hi ha 90 menys. El descens de població és menys acusat del que caldria esperar.
* S'observa que la població dels municipis menys poblats l'any 1975, ha crescut més a l'any 2020 en aquells més propers a les ciutats amb més habitants.

Respecte el mite dels municipis petits: son agrícoles i envellits?

* A data 1 de gener de 2020 s’obseva que els municipis amb menys habitants tenen un percentatge més gran de persones majors de 65 anys, tenen un percentatge de població activa de més edat dedicada al sector primari i ha crescut el percentatge de persones grans. Als municipis amb més habitants, s'observa la tendència contrària.

Respecte els efectes de la pandèmia de COVID-19, al període 2020-2022

* S'observen variacions petites de població, no són xifres que permetin concloure un trasvassament clar de població, tot i que sí que es veu una tendència de disminució als grans nuclis i d'augment a municipis de muntanya.

### Descripció dels fitxers R

**habitants.R**
Variació del nombre d’habitants als períodes 1975-2020 i 2020-2022. Escriptura dels resultats a dos fitxers csv amb la informació processada.

**dftoviz.R**
Script per a l’adequació dels dataframes processats per a exportar-los a l’eina flourish i mostrar la informació desitjada. [quins csv s’han generat en aquest cas...]

**economics.R**
Script per a la creació d’un fitxer CSV amb la informació del nombre de persones ocupades a cada municipi en funció dels sectors econòmics a data 31 de desembre de 2019

**edats.R**
Script per a la creació d’un fitxer CSV amb la variació d'habitants per grups d’edat a cada municipi al període 2000-2020


