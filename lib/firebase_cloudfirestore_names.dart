//Coleção de Feedback
const String FIRESTORE_DATABASE_COLLECTION_FEEDBACKS = 'feedbacks';
const String FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_KEY = 'feedback_key';
const String FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_EMAIL = 'feedback-sended-by';
const String FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_FEEDBACK_TEXT =
    'feedback-text';
const String FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_DATE = 'feedback-send-date';
const String FIRESTORE_DATABASE_FEEDBACK_DOCUMENT_ASREAD = 'feedback-as-read';

//Coleção de Usuarios
const String FIRESTORE_DATABASE_COLLECTION_USERS = 'users';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_BIO = 'bio';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_BIRTH_DATE = 'birth-date';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_COMMENTS_SENDED =
    'comments-sended';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_EMAIL = 'email';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWED_BY = 'followed-by';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_FOLLOWER_OF = 'follower-of';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_FULLNAME = 'fullname';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_GENERE = 'genere';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_KEY = 'key-from-user';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_COMMENTS =
    'likes-in-comments';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_LIKES_IN_UPLOADS =
    'likes-in-uploads';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_MY_LINKS = 'my-links';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_REFERENCE =
    'profile-image-reference';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_PROFILE_IMAGE_URL =
    'profile-image-url';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_SAVED_POSTS = 'saved-posts';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_USER_UPLOADS = 'user-uploads';
const String FIRESTORE_DATABASE_USERS_DOCUMENT_USERNAME = 'username';

//Coleção de Uploads
const String FIRESTORE_DATABASE_COLLECTION_UPLOADS = 'uploads';
const String FIRESTORE_DATABASE_UPLOADS_COMMENT_KEYS = 'comment-keys';
const String FIRESTORE_DATABASE_UPLOADS_DESCRIPTION = 'description';
const String FIRESTORE_DATABASE_UPLOADS_KEY = 'key-from-upload';
const String FIRESTORE_DATABASE_UPLOADS_LIKED_BY = 'liked-by';
const String FIRESTORE_DATABASE_UPLOADS_SAVED_BY = 'saved-by';
const String FIRESTORE_DATABASE_UPLOADS_UPLOAD_DATE_TIME = 'upload-date-time';
const String FIRESTORE_DATABASE_UPLOADS_UPLOAD_STORAGE_REFERENCE =
    'upload-storage-reference';
const String FIRESTORE_DATABASE_UPLOADS_UPLOAD_IMAGE_URL = 'upload-image-url';
const String FIRESTORE_DATABASE_UPLOADS_UPLOADER_KEY = 'uploader-key';

//Coleção de Comentarios
const String FIRESTORE_DATABASE_COLLECTION_COMMENTARIES = 'commentaries';
const String FIRESTORE_DATABASE_COMMENTARIES_COMMENT = 'comment';
const String FIRESTORE_DATABASE_COMMENTARIES_COMMENT_LIKED_BY =
    'comment-liked-by';
const String FIRESTORE_DATABASE_COMMENTARIES_COMMENT_KEY = 'comment-key';
const String FIRESTORE_DATABASE_COMMENTARIES_SENDED_BY = 'sended-by';
const String FIRESTORE_DATABASE_COMMENTARIES_KEY_FROM_COMMENT_UPLOAD =
    'key-from-comment-upload';

/*Padrão de upload para o Storage e salvar auxiliar a salvar no database
**"users/(User id do Cloud Firestore)/profile-images/imagem" (Para Imagens de perfil)
**"users/(User id do Cloud Firestore)/upload/imagem" (Para postagens)*/
const String FIREBASE_STORAGE_USERS = '/users/';
const String FIREBASE_STORAGE_USERS_PROFILE = '/profile-images/';
const String FIREBASE_STORAGE_USERS_UPLOADS = '/uploads/';
