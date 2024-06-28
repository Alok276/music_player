import 'package:flutter/material.dart';


class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
  
    return  Scaffold(
   backgroundColor:const Color(0xff121212),
      body:Column(
      
      children: [
          // start page image-----
          Image.asset('assets/images/start.png'),
          const SizedBox(height: 10,),
         const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
             
             Center(
              
               child: Text("Millions of Songs",
               textAlign: TextAlign.center,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                           fontWeight: FontWeight.w700,
                           fontSize: 28,
                           color: Color.fromARGB(255, 255, 255, 255),
      
                          ),
                          ),
             )
          ],
         ),
         const SizedBox(height: 02,),
          const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
             
             Center(
              
               child: Text("Free on Spotify.",
               textAlign: TextAlign.center,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                           fontWeight: FontWeight.w700,
                           fontSize: 28,
                           color: Color.fromARGB(255, 255, 255, 255),
      
                          ),
                          ),
             )
          ],
         ),
         const SizedBox(height: 20,),
        GestureDetector(
      onTap: null,
      child: Container(
          width: 300,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xff1ED760),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: const Center(
            child: Text(
             "Sign up free",
              style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize:18,
                  color: Colors.black),
            ),
          )),
    ),
      const SizedBox(height: 20,),
      //google login----
        GestureDetector(
      onTap: null,
      child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: const  Color(0xff121212),
            borderRadius:const  BorderRadius.all(Radius.circular(50)
            ),
            border: Border.all(color: Colors.white)
          ),
          
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/google_icon.png"),
                  ),

             const  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child:  Text(
                 "Continue with Google",
                  style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:18,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    ),
    const SizedBox(height: 20,),
    //Facebook login---
        GestureDetector(
      onTap: null,
      child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: const  Color(0xff121212),
            borderRadius:const  BorderRadius.all(Radius.circular(50)
            ),
            border: Border.all(color: Colors.white)
          ),
          
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/facebook.png"),
                  ),

             const  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child:  Text(
                 "Continue with Facebook",
                  style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:18,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    ),
    const SizedBox(height: 20,),
    //login with Apple
      GestureDetector(
      onTap: null,
      child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: const  Color(0xff121212),
            borderRadius:const  BorderRadius.all(Radius.circular(50)
            ),
            border: Border.all(color: Colors.white)
          ),
          
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset("assets/images/apple.png"),
                  ),

             const  Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child:  Text(
                 "Continue with Apple",
                  style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize:18,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    ),
    const SizedBox(height: 20,),

    //login option -------------
    GestureDetector(
      onTap: null,
      child: const Text("Login",
      style: TextStyle(
        color:   Color(0xffffffff),
        fontSize: 17,
        fontWeight: FontWeight.w500
      ),),
    ),


         
      ]  ),

    );
  }
}