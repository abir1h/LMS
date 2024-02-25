import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNotesAction();
  Future<ResponseModel> getNotesByContentAction(
      int contentId, String contentType);
  Future<ResponseModel> getNoteDetailsAction(int noteId);
  Future<ResponseModel> createNoteAction(NoteDataModel noteDataModel);
  Future<ResponseModel> updateNoteAction(NoteDataModel noteDataModel);
  Future<ResponseModel> deleteNoteAction(int noteId);
}

class NoteRemoteDataSourceImp extends NoteRemoteDataSource {
  @override
  Future<ResponseModel> getNotesAction() async {
    final responseJson =
        await Server.instance.getRequest(url: ApiCredential.getNotes);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.listFromJson(json));
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

  @override
  Future<ResponseModel> getNoteDetailsAction(int noteId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getNotes}/$noteId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> createNoteAction(NoteDataModel noteDataModel) async {
    final responseJson = await Server.instance.postRequest(
        url: ApiCredential.getNotes, postData: noteDataModel.toJson());
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> updateNoteAction(NoteDataModel noteDataModel) async {
    Map<String, dynamic> data = noteDataModel.toJson();
    data["_method"] = "PUT";
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.getNotes}/${noteDataModel.id}", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> deleteNoteAction(int noteId) async {
    final responseJson = await Server.instance
        .deleteRequest(url: "${ApiCredential.getNotes}/$noteId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NoteDataModel.fromJson(json));
    return responseModel;
  }
}
