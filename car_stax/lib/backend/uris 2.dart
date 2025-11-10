final website_path = "https://farrukhanwar.site";

final login_uri = Uri.parse(website_path + '/api/auth/login');

final register_uri = Uri.parse(website_path + "/api/auth/signup");

final forgot_password_uri = Uri.parse(website_path + "/api/auth/forgot-password");

final logout_uri = Uri.parse(website_path + "/api/auth/logout");

final add_car_uri = Uri.parse(website_path + "/api/Car/add");

final delete_car_uri = Uri.parse(website_path + "/api/Car/");

final edit_car_uri = Uri.parse(website_path + "/api/Car/");

final get_cars_uri = Uri.parse(website_path + "/api/Car/");

final mongo_db = 'mongodb+srv://hoangphan030103_db_user:p6BGXTI45J0H0alP@cluster0.lgtqoi5.mongodb.net/carRental_db?retryWrites=true&w=majority&appName=Cluster0';