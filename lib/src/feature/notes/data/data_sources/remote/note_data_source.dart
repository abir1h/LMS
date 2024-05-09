import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/note_data_model.dart';
import '../../models/paginated_note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction(int pageNumber);
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> deleteNotesAction(int noteId);
  Future<ResponseModel> getNotesByContentAction(
      int contentId, String contentType);
}

class NoteRemoteDataSourceImp extends NoteRemoteDataSource {
  @override
  Future<ResponseModel> getNoteListAction(int pageNumber) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getNotes}?page=$pageNumber");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => PaginatedNoteDataModel.fromJson(json));

    return responseModel;
  }

  @override
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel) async {
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.createNotes, postData: noteDataModel);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel) async {
    Map<String, dynamic> data = noteDataModel.toJson();
    final responseJson = await Server.instance.putRequest(
        url: "${ApiCredential.createNotes}/${noteDataModel.id}",
        postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteNotesAction(int noteId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.createNotes}/$noteId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getNotesByContentAction(
      int contentId, String contentType) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getNotesByContent}?content_id=$contentId&content_type=$contentType");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.listFromJson(json));
    return responseModel;
  }
}
