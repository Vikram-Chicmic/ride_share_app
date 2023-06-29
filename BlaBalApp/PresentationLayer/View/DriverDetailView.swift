//
//  DriverDetailView.swift
//  BlaBalApp
//
//  Created by ChicMic on 29/06/23.
//

import SwiftUI

struct DriverDetailView: View {
    var data: DecodeUser
    var body: some View {
        if data.code == 200 {
            Text(data.user.firstName + " " + data.user
                .lastName).fontWeight(.semibold).font(.title2)
            VStack(spacing: 10) {
                RideDetailTileView(title: Constants.Texts.model, value:data.user.dob) //MODEL
                RideDetailTileView(title: Constants.Texts.vehicleNumber, value: data.user.phoneNumber)
                RideDetailTileView(title: Constants.Texts.Manufactureyear, value: String(data.user.email))
                RideDetailTileView(title: Constants.Texts.VehicleType, value: data.user.bio)
                RideDetailTileView(title: Constants.Texts.color, value: Helper().formatDate(data.user.createdAt) ?? "2023-06-27T11:00:23.662Z")
            }.padding().background(Color.gray.opacity(0.1)).cornerRadius(20)
        }    }
}

//struct DriverDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DriverDetailView(data: DecodeUser("code": 200, "user": {
//            "activate_token" = "X6fMdpAuq0AJiNcfdD-O5A";
//            activated = "<null>";
//            "activated_at" = "<null>";
//            "activation_digest" = "$2a$12$s00VY.gfv.ApMne5IxkO8.ADZ9K1aYfLk6mmIHA.V/lRHEzXaoHW.";
//            "average_rating" = "<null>";
//            bio = "<null>";
//            "created_at" = "2023-06-27T11:00:23.662Z";
//            dob = "2008-12-08";
//            email = "viki123@gmail.com";
//            "first_name" = Vikram;
//            id = 325;
//            jti = "0f897462-6272-41e8-ab40-177efc59756d";
//            "last_name" = Kumar;
//            otp = 0;
//            "phone_number" = "<null>";
//            "phone_verified" = "<null>";
//            "postal_address" = "<null>";
//            "session_key" = "<null>";
//            title = "Mr.";
//            "travel_preferences" = "<null>";
//            "updated_at" = "2023-06-29T08:21:52.500Z";
//        }, "image_url": https:"//f1ce-112-196-113-2.ngrok-free.app/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBaUFCIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--814765b2d2a3340308757af50089f500f10add2b/Vikram.png"))
//    }
//}
