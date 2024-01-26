#import "template.typ": *
#show: book.with(
  mainColor: rgb(0, 46, 82),
  title: [Els discursos com a mecanisme legitimador \ de polítiques restrictives de llibertat],
  subtitle: "El delicte d'injúries a la Corona",
  author: "Josep Monjo",
  dedication: [_*«Aquí la paraula ho és tot: \ 
  és la nostra acció, el nostre medi i el nostre fi»*._ \ 
Pasqual Maragall. \
Elogi de la paraula (1903)],
  logo: "img/uv.svg",
  bottomText: [Treball Final de Màster en Sociologia i Antropologia de les Polítiques Públiques. \
  *Premi Extraordinari de Màster 2013* \
  Tutor: _Dr. Rafael Xambó_ \ ],

  publishing-info: [
    2013 © JOSEP MONJO \
    Reedició 2024 \
    josep\@monjo.eu \
    València \
    #link("https://monjo.eu/") \
    \

    CC BY-NC-SA 4.0 DEED \
    Reconeixement-NoComercial-CompartirIgual 4.0 Internacional \
    #link("https://creativecommons.org/licenses/by-nc-sa/4.0/deed.ca") \
  
  ],
)

#include {"capitols/01-intro.typ"}

#bibliography(
"./bibliografia/export-data.bib",
title: "Bibliografia",
style: "apa",
)