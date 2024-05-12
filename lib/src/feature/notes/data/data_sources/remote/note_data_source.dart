import '../../../../../core/constants/common_imports.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/note_data_model.dart';
import '../../models/paginated_note_data_model.dart';

abstract class NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction(int pageNumber,
      {String? sortBy, bool? sortDesc});
  Future<ResponseModel> createNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> updateNotesAction(NoteDataModel noteDataModel);
  Future<ResponseModel> deleteNotesAction(int noteId);
}

class NoteRemoteDataSourceImp extends NoteRemoteDataSource {
  Future<ResponseModel> getNoteListAction(int pageNumber,
      {String? sortBy, bool? sortDesc}) async {
    String url = "${ApiCredential.getNotes}?page=$pageNumber";

    if (sortBy != null) {
      url += "&sortBy=$sortBy&sortDesc=true";
    }
    if (sortDesc != null) {
      url += "&sortDesc=$sortDesc";
    }

    final responseJson = await Server.instance.getRequest(url: url);
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
        responseJson, (dynamic json) => NoteDataModel.listFromJson(json));
    return responseModel;
  }
}
