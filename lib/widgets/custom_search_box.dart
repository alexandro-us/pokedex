import 'package:flutter/material.dart';

class CustomSearchBox extends StatefulWidget {
  const CustomSearchBox({
    Key? key, 
    required this.controller, 
    required this.placeholder, 
    this.backgroundColor, 
    this.hintStyle, 
    this.style, 
    this.border, required this.actionClear, required this.actionSearch
  }) : super(key: key);

  final TextEditingController controller;
  final String placeholder;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final BorderSide? border;
  final Function actionClear;
  final Function(String val) actionSearch;

  @override
  State<CustomSearchBox> createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {

  bool clear = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      child: TextFormField(
        controller: widget.controller,
        onChanged: (value) {
          if(value.isNotEmpty){
            clear = true; 
            widget.actionSearch(value);
          } else {
            clear = false;
          }
          
          setState(() {});
        },
        decoration: InputDecoration(
          filled: widget.backgroundColor != null ? true : false,
          fillColor: widget.backgroundColor,
          prefixIcon: const Icon(Icons.search, color: Colors.grey,),
          hintText: widget.placeholder,
          suffixIcon: (clear) 
              ? IconButton(
                onPressed: (){
                  widget.actionClear();
                  setState(() {
                    clear = false;
                  });
                }, 
                icon: const Icon(Icons.close, color: Colors.grey,))
              : null,
          hintStyle: widget.hintStyle ?? const TextStyle(fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 8, 10, 8),
          
        ),
        style: widget.style ?? const TextStyle(fontSize: 18, color:Colors.black54),
        textAlign: TextAlign.start,
      ),
    );
  }
}