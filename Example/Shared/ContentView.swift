//
//  ContentView.swift
//  Shared
//
//  Created by Hai Feng Kao on 07/22/2021.
//

import SwiftUI
import SwiftUINavigationBarColor

struct ContentView: View {
    #if os(iOS)
        var iosView: some View {
            NavigationView {
                VStack {
                    Text("Hello, world!").padding()
                    NavigationLink(
                        destination: DetailView1(),
                        label: {
                            Text("Next")
                        }
                    )
                }

                .navigationBarTitleDisplayMode(.inline)
            }

            .navigationTransparentBar(tintColor: .white)
        }

    #else

        var macOSView: some View {
            NavigationView {
                VStack {
                    Text("Hello, world!").padding()
                    NavigationLink(
                        destination: DetailView1(),
                        label: {
                            Text("Next")
                        }
                    )
                }
            }
        }

    #endif

    var body: some View {
        #if os(iOS)
            iosView
        #else
            macOSView
        #endif
    }
}

struct DetailView1: View {
    var body: some View {
        VStack {
            Text("Hello, Red!").padding()
            NavigationLink(
                destination: DetailView2(),
                label: {
                    Text("Next")
                }
            )

        }.navigationBarBackground {
            Color.red.shadow(radius: 1) // don't forget the shadow under the opaque bar
        }
    }
}

struct DetailView2: View {
    var body: some View {
        VStack {
            Text("Hello, Blue!").padding()
            NavigationLink(
                destination: DetailView3(),
                label: {
                    Text("Next")
                }
            )
        }.navigationBarBackground {
            Color.blue.shadow(radius: 1) // don't forget the shadow under the opaque bar
        }
    }
}

struct DetailView3: View {
    var body: some View {
        VStack {
            Text("Hello, Rainbow!").padding()
            NavigationLink(
                destination: DetailView4(),
                label: {
                    Text("Next")
                }
            )
        }.navigationBarBackground {
            Image("rainbow").resizable().background(Color.pink)
        }
    }
}

struct DetailView4: View {
    var body: some View {
        VStack {
            Image("rainbow").resizable().background(Color.pink).edgesIgnoringSafeArea(.top)
        }.navigationBarBackground {
            #if os(iOS)
                VisualEffectBlur(blurStyle: .systemChromeMaterialDark, vibrancyStyle: .fill) {
                    Color.clear
                }

            #else
                VisualEffectBlur()
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
