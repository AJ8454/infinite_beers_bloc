// To parse this JSON data, do
//
//     final beerModel = beerModelFromJson(jsonString);

import 'dart:convert';

List<BeerModel?>? beerModelFromJson(String str) => json.decode(str) == null
    ? []
    : List<BeerModel?>.from(
        json.decode(str)!.map((x) => BeerModel.fromJson(x)));

String beerModelToJson(List<BeerModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class BeerModel {
  BeerModel({
    this.id,
    this.name,
    this.tagline,
    this.firstBrewed,
    this.description,
    this.imageUrl,
    this.abv,
    this.ibu,
    this.targetFg,
    this.targetOg,
    this.ebc,
    this.srm,
    this.ph,
    this.attenuationLevel,
    this.volume,
    this.boilVolume,
    this.method,
    this.ingredients,
    this.foodPairing,
    this.brewersTips,
    this.contributedBy,
  });

  int? id;
  String? name;
  String? tagline;
  String? firstBrewed;
  String? description;
  String? imageUrl;
  double? abv;
  double? ibu;
  int? targetFg;
  double? targetOg;
  int? ebc;
  double? srm;
  double? ph;
  double? attenuationLevel;
  BoilVolume? volume;
  BoilVolume? boilVolume;
  Method? method;
  Ingredients? ingredients;
  List<String?>? foodPairing;
  String? brewersTips;
  ContributedBy? contributedBy;

  factory BeerModel.fromJson(Map<String, dynamic> json) => BeerModel(
        id: json["id"],
        name: json["name"],
        tagline: json["tagline"],
        firstBrewed: json["first_brewed"],
        description: json["description"],
        imageUrl: json["image_url"],
        abv: json["abv"].toDouble(),
        ibu: json["ibu"],
        targetFg: json["target_fg"],
        targetOg: json["target_og"].toDouble(),
        ebc: json["ebc"],
        srm: json["srm"],
        ph: json["ph"],
        attenuationLevel: json["attenuation_level"].toDouble(),
        volume: BoilVolume.fromJson(json["volume"]),
        boilVolume: BoilVolume.fromJson(json["boil_volume"]),
        method: Method.fromJson(json["method"]),
        ingredients: Ingredients.fromJson(json["ingredients"]),
        foodPairing: json["food_pairing"] == null
            ? []
            : List<String?>.from(json["food_pairing"]!.map((x) => x)),
        brewersTips: json["brewers_tips"],
        contributedBy: contributedByValues.map[json["contributed_by"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tagline": tagline,
        "first_brewed": firstBrewed,
        "description": description,
        "image_url": imageUrl,
        "abv": abv,
        "ibu": ibu,
        "target_fg": targetFg,
        "target_og": targetOg,
        "ebc": ebc,
        "srm": srm,
        "ph": ph,
        "attenuation_level": attenuationLevel,
        "volume": volume!.toJson(),
        "boil_volume": boilVolume!.toJson(),
        "method": method!.toJson(),
        "ingredients": ingredients!.toJson(),
        "food_pairing": foodPairing == null
            ? []
            : List<dynamic>.from(foodPairing!.map((x) => x)),
        "brewers_tips": brewersTips,
        "contributed_by": contributedByValues.reverse![contributedBy],
      };
}

class BoilVolume {
  BoilVolume({
    this.value,
    this.unit,
  });

  double? value;
  Unit? unit;

  factory BoilVolume.fromJson(Map<String, dynamic> json) => BoilVolume(
        value: json["value"].toDouble(),
        unit: unitValues.map[json["unit"]],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unitValues.reverse![unit],
      };
}

enum Unit { LITRES, GRAMS, KILOGRAMS, CELSIUS }

final unitValues = EnumValues({
  "celsius": Unit.CELSIUS,
  "grams": Unit.GRAMS,
  "kilograms": Unit.KILOGRAMS,
  "litres": Unit.LITRES
});

enum ContributedBy { SAM_MASON_SAMJBMASON, ALI_SKINNER_ALI_SKINNER }

final contributedByValues = EnumValues({
  "Ali Skinner <AliSkinner>": ContributedBy.ALI_SKINNER_ALI_SKINNER,
  "Sam Mason <samjbmason>": ContributedBy.SAM_MASON_SAMJBMASON
});

class Ingredients {
  Ingredients({
    this.malt,
    this.hops,
    this.yeast,
  });

  List<Malt?>? malt;
  List<Hop?>? hops;
  String? yeast;

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        malt: json["malt"] == null
            ? []
            : List<Malt?>.from(json["malt"]!.map((x) => Malt.fromJson(x))),
        hops: json["hops"] == null
            ? []
            : List<Hop?>.from(json["hops"]!.map((x) => Hop.fromJson(x))),
        yeast: json["yeast"],
      );

  Map<String, dynamic> toJson() => {
        "malt": malt == null
            ? []
            : List<dynamic>.from(malt!.map((x) => x!.toJson())),
        "hops": hops == null
            ? []
            : List<dynamic>.from(hops!.map((x) => x!.toJson())),
        "yeast": yeast,
      };
}

class Hop {
  Hop({
    this.name,
    this.amount,
    this.add,
    this.attribute,
  });

  String? name;
  BoilVolume? amount;
  Add? add;
  Attribute? attribute;

  factory Hop.fromJson(Map<String, dynamic> json) => Hop(
        name: json["name"],
        amount: BoilVolume.fromJson(json["amount"]),
        add: addValues.map[json["add"]],
        attribute: attributeValues.map[json["attribute"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount!.toJson(),
        "add": addValues.reverse![add],
        "attribute": attributeValues.reverse![attribute],
      };
}

enum Add { START, MIDDLE, END, DRY_HOP }

final addValues = EnumValues({
  "dry hop": Add.DRY_HOP,
  "end": Add.END,
  "middle": Add.MIDDLE,
  "start": Add.START
});

enum Attribute { BITTER, FLAVOUR, AROMA, ATTRIBUTE_FLAVOUR }

final attributeValues = EnumValues({
  "aroma": Attribute.AROMA,
  "Flavour": Attribute.ATTRIBUTE_FLAVOUR,
  "bitter": Attribute.BITTER,
  "flavour": Attribute.FLAVOUR
});

class Malt {
  Malt({
    this.name,
    this.amount,
  });

  String? name;
  BoilVolume? amount;

  factory Malt.fromJson(Map<String, dynamic> json) => Malt(
        name: json["name"],
        amount: BoilVolume.fromJson(json["amount"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount!.toJson(),
      };
}

class Method {
  Method({
    this.mashTemp,
    this.fermentation,
    this.twist,
  });

  List<MashTemp?>? mashTemp;
  Fermentation? fermentation;
  String? twist;

  factory Method.fromJson(Map<String, dynamic> json) => Method(
        mashTemp: json["mash_temp"] == null
            ? []
            : List<MashTemp?>.from(
                json["mash_temp"]!.map((x) => MashTemp.fromJson(x))),
        fermentation: Fermentation.fromJson(json["fermentation"]),
        twist: json["twist"],
      );

  Map<String, dynamic> toJson() => {
        "mash_temp": mashTemp == null
            ? []
            : List<dynamic>.from(mashTemp!.map((x) => x!.toJson())),
        "fermentation": fermentation!.toJson(),
        "twist": twist,
      };
}

class Fermentation {
  Fermentation({
    this.temp,
  });

  BoilVolume? temp;

  factory Fermentation.fromJson(Map<String, dynamic> json) => Fermentation(
        temp: BoilVolume.fromJson(json["temp"]),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp!.toJson(),
      };
}

class MashTemp {
  MashTemp({
    this.temp,
    this.duration,
  });

  BoilVolume? temp;
  int? duration;

  factory MashTemp.fromJson(Map<String, dynamic> json) => MashTemp(
        temp: BoilVolume.fromJson(json["temp"]),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp!.toJson(),
        "duration": duration,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
